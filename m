Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C32C3C6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 19:05:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8951D2081B
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 19:05:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="R7A3zKxi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8951D2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725931AbeJaEAW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 00:00:22 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:51744 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725743AbeJaEAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 00:00:21 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9UJ4RXX004532;
        Tue, 30 Oct 2018 19:05:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=o78ILJnIH8Xfvc6/30XumdhVhRWD189CZ9vRKakZeIU=;
 b=R7A3zKxilhtoR3U3XRg0fdgAQRP4C+Mnh6mfAwqu1edSFkc8+5BCxHPKbRVm713zt7YN
 HJEOHK5674jcucKwvy2TOvL5xfXGmUfa1ri8d4QWKVidAX0xbwx/Fgx44/oHw5Wx7EJU
 9WqybD6+nLpw6zEjVz4AFyVjUJZMJmN5FKAEMrq9BQu1o62opz5Gp7ilPEZORDNJQ/7q
 MCpY4xPMd6IV66EtFTNwCq8aMVk4ZfAACXSZaVY/2O4Z2NJPtQmFrjDVrgSVS2gk2LpI
 j8EMaRXeNfL/HIu/crwNr2eNVuNQTuT+UYWYXy2yXjVMIxmKc1RbxvpITbNW8zdwJO9X xQ== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2nducm35c9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Oct 2018 19:05:20 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w9UJ5JGN020614
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Oct 2018 19:05:19 GMT
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w9UJ5IIW009172;
        Tue, 30 Oct 2018 19:05:18 GMT
Received: from Santoshs-MacBook-Pro.local (/10.11.38.116)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 30 Oct 2018 12:05:18 -0700
Subject: Re: [PATCH] soc: ti: QMSS: Fix usage of irq_set_affinity_hint
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Marc Zyngier <marc.zyngier@arm.com>
Cc:     Santosh Shilimkar <ssantosh@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        stable@vger.kernel.org
References: <20181030111103.12110-1-marc.zyngier@arm.com>
 <ea4e3273-39da-d9f9-49ce-f18268767ce3@oracle.com>
 <20181030190051.GA1697@kroah.com>
From:   "santosh.shilimkar@oracle.com" <santosh.shilimkar@oracle.com>
Organization: Oracle Corporation
Message-ID: <e5dba35a-03bf-70e7-ad3c-8f08631400bc@oracle.com>
Date:   Tue, 30 Oct 2018 12:05:18 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181030190051.GA1697@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9062 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=736
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810300160
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/30/18 12:00 PM, Greg Kroah-Hartman wrote:
> On Tue, Oct 30, 2018 at 10:18:08AM -0700, Santosh Shilimkar wrote:
>> Hi Greg,

[...]

>> Would be able to apply this fix from Marc for stable or it needs
>> to be re-posted with CC to stable ?
> 
> <formletter>
> 
> This is not the correct way to submit patches for inclusion in the
> stable kernel tree.  Please read:
>      https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
> for how to do this properly.
> 
Thanks Greg !!

Hi Marc,
Could you please resend the patch to the stable ?

Regards,
Santosh


