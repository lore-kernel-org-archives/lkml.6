Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C2DEC3279B
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 00:32:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23094240B5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 00:32:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="c4gdIgvy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23094240B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753067AbeGEAcj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 20:32:39 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:59756 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752965AbeGEAch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 20:32:37 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w650TpD4036916;
        Thu, 5 Jul 2018 00:32:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2017-10-26;
 bh=D6YZCyLpkZ/T8McVZcSk2Kew01fZOZyqUQ58z8/BWwQ=;
 b=c4gdIgvyYudRU7ICI18sqRJWLZH94y698rumEsJO3y9813LZpgWxIIVzdJxvmVH6jseL
 Pr29mm3even24/UQm9YtAw681h0cJfuP2nJI+3Qm6LMIbPivIHXDzo37ARQDsPk0HUyP
 vkn+dgDwxaOIWeWGRhn86Aa0qaOFP57Uizijv3bl12Rn08CadAHFGHh1ws6+OhFHMIVN
 XIyr6t1+6pKFRuGo+AU8+cZYK6pX1a317m7rqhwvNrL0n+VMFEGsk/FJq4miji9aqAss
 leD87AeBeTqVG20pkRYiYCVYU37Uyaxb34MmajnawaBqG5fZEPtDiWk3GWOhC260x17L VA== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2120.oracle.com with ESMTP id 2k0dnjkxhp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Jul 2018 00:32:29 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w650WRi8022767
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 5 Jul 2018 00:32:27 GMT
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w650WQMB009686;
        Thu, 5 Jul 2018 00:32:26 GMT
Received: from dhcp-10-159-228-223.vpn.oracle.com (/10.159.228.223)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 04 Jul 2018 17:32:26 -0700
Subject: Re: general protection fault in rds_ib_get_mr
To:     Eric Biggers <ebiggers3@gmail.com>, linux-rdma@vger.kernel.org,
        rds-devel@oss.oracle.com
Cc:     syzbot <syzbot+b51c77ef956678a65834@syzkaller.appspotmail.com>,
        davem@davemloft.net, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <089e082ce58896ad350567ee4825@google.com>
 <20180513211058.GE677@sol.localdomain>
 <27665604-6a26-36e2-3a58-9c8b3d9eab80@oracle.com>
 <20180704213506.GH725@sol.localdomain>
From:   "santosh.shilimkar@oracle.com" <santosh.shilimkar@oracle.com>
Organization: Oracle Corporation
Message-ID: <04c882dc-332e-92d6-fe76-b1dd3bedd71c@oracle.com>
Date:   Wed, 4 Jul 2018 17:32:20 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180704213506.GH725@sol.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8944 signatures=668704
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=909
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807050004
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/4/18 2:35 PM, Eric Biggers wrote:
> On Sun, May 13, 2018 at 10:46:37PM -0700, santosh.shilimkar@oracle.com wrote:
>> On 5/13/18 2:10 PM, Eric Biggers wrote:
>>> On Wed, Mar 21, 2018 at 09:00:01AM -0700, syzbot wrote:
>>
>> [...]
>>
>>
>>> Still reproducible on Linus' tree (commit 66e1c94db3cd4) and linux-next
>>> (next-20180511).  Here's a simplified reproducer:
>>>
>> Thanks for the test case !!
>>

[...]

> 
> Ping; this RDS bug is still unfixed.  The same reproducer I gave earlier still
> works, even when run as a non-root user.  I tested upstream commit
> fc36def997cfd6 (v4.18-rc3-113-gfc36def997cfd), and linux-next commit
> bce40927669338 (next-20180704).
> 
Yeah I haven't sent a fix for this yet. Downstream we have refactored
MR code and I wanted to get that upstream. With that this bug will
also get addressed. I was hoping to get that series but since some
optimisation is still pending investigations its getting delayed.

Will find out if I can fix this panic in meantime with smaller change.
Thanks for reminder.

Regards,
Santosh
