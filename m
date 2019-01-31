Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0849C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 21:41:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABF9A21872
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 21:41:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TgVNb1/q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728657AbfAaVlo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 16:41:44 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:54302 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726233AbfAaVln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 16:41:43 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0VLXaQK149776;
        Thu, 31 Jan 2019 21:40:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=RQb5/8LhrDwHwIxWuRZz/TvSJI1H3crNeKps1AN49TI=;
 b=TgVNb1/qiZIEv14vkpIyyWdGnYo+yNICxHomKlqYskcU4QzuKuEkYQ7kywzD2TOcieqU
 bkMFzoHCMWqWi2QZF2cqa4zv47JB49YtU2m2yEnp3pUxViMIZ/uG7oOsyusslJxQLe5O
 noNxs/MEvRZeTX34NJoL+F9UUBwvEW9n6ihPNxc6OIaos2tmPAwKAl01+7Bj6CGaxmn4
 +pmE4UAbRfEpmASMLpd6Ehmw3gKUow6ohrV2rltQz/wRe6pSGiFPvfW+QbBWsVmL08UC
 n9+jOPHTNGUegEQ+OE/nmubJ+B6FjSeNzYu4sZx3koLJkREdlEe1BuX8jXybg/yDSO9I Zg== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2130.oracle.com with ESMTP id 2q8d2ekgaf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Jan 2019 21:40:23 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x0VLeNJG002538
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Jan 2019 21:40:23 GMT
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x0VLeLsR009488;
        Thu, 31 Jan 2019 21:40:22 GMT
Received: from dhcp-10-65-146-169.vpn.oracle.com (/10.65.146.169)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 31 Jan 2019 13:40:21 -0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.1\))
Subject: Re: [PATCH 1/1] mm/vmalloc: convert vmap_lazy_nr to atomic_long_t
From:   William Kucharski <william.kucharski@oracle.com>
In-Reply-To: <20190131162452.25879-1-urezki@gmail.com>
Date:   Thu, 31 Jan 2019 14:40:20 -0700
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Garnier <thgarnie@google.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joelaf@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, Tejun Heo <tj@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <660AEEE7-0221-42EF-BFE1-808760AA7910@oracle.com>
References: <20190131162452.25879-1-urezki@gmail.com>
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
X-Mailer: Apple Mail (2.3445.104.1)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9153 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=738 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1901310157
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jan 31, 2019, at 9:24 AM, Uladzislau Rezki (Sony) =
<urezki@gmail.com> wrote:
>=20
> vmap_lazy_nr variable has atomic_t type that is 4 bytes integer
> value on both 32 and 64 bit systems. lazy_max_pages() deals with
> "unsigned long" that is 8 bytes on 64 bit system, thus vmap_lazy_nr
> should be 8 bytes on 64 bit as well.

Looks good.

Reviewed-by: William Kucharski <william.kucharski@oracle.com>=
