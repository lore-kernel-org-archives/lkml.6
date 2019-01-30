Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37810C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 11:00:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A1602184D
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 11:00:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QG8HzlYV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730672AbfA3LA3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 06:00:29 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:55542 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727043AbfA3LA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 06:00:28 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0UAx8pi116005;
        Wed, 30 Jan 2019 11:00:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=61scKswmPbnHoOk96Jf+ol3O9mYXOld0qByaXCb56ns=;
 b=QG8HzlYV9F4869aLEYwiGZCj/XYcJ4bTZiDrFGX5sK44a5Zf1BdNzdsaz4JEvMET9MWv
 ikUK3ydrtqcO+K1hGtf+3zWFc9Twh++aj+8BCzAKOx1pD0rQpIxi7GyFzsdqQavxUBMN
 VZEc5HPBtR/ztMu5TqjhBQ5DnHRViYYIwUxrRbh/dsYB4+Q/PjUnfIEXMpzUxr+o72Xk
 czFgx8MdEjO75dQe7v8EnSEQG3uBIChHnipFJp/oKaVk4krpHBdsfNttLkkj0Y4ahVju
 RARxxh4ov7jkEpbHv1Bgv/cwPBpQpKNmrqG/lwN+AuhWUqjmAaEGtCcep3lecxR+GF5l Bw== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2130.oracle.com with ESMTP id 2q8eyuhukp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Jan 2019 11:00:00 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x0UAxs9s014114
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Jan 2019 10:59:54 GMT
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x0UAxrmi028591;
        Wed, 30 Jan 2019 10:59:53 GMT
Received: from [192.168.0.110] (/73.243.10.6)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 30 Jan 2019 02:59:53 -0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.1\))
Subject: Re: [PATCH v2 2/2] x86/xen: dont add memory above max allowed
 allocation
From:   William Kucharski <william.kucharski@oracle.com>
In-Reply-To: <20190130082233.23840-3-jgross@suse.com>
Date:   Wed, 30 Jan 2019 03:59:52 -0700
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        xen-devel@lists.xenproject.org, x86@kernel.org, linux-mm@kvack.org,
        boris.ostrovsky@oracle.com, sstabellini@kernel.org, hpa@zytor.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
Content-Transfer-Encoding: 7bit
Message-Id: <C4A55B5E-47A5-454A-AB90-AB52DF42CD88@oracle.com>
References: <20190130082233.23840-1-jgross@suse.com>
 <20190130082233.23840-3-jgross@suse.com>
To:     Juergen Gross <jgross@suse.com>
X-Mailer: Apple Mail (2.3445.104.1)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9151 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=753 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1901300089
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jan 30, 2019, at 1:22 AM, Juergen Gross <jgross@suse.com> wrote:
> 
> +#ifdef CONFIG_MEMORY_HOTPLUG
> +			/*
> +			 * Don't allow adding memory not in E820 map while
> +			 * booting the system. Once the balloon driver is up
> +			 * it will remove that restriction again.
> +			 */
> +			max_mem_size = xen_e820_table.entries[i].addr +
> +				       xen_e820_table.entries[i].size;
> +#endif
> 		}
> 
> 		if (!discard)

Reviewed-by: William Kucharski <william.kucharski@oracle.com>

