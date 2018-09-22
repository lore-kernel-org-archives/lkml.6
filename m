Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB344C433F4
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 01:16:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D0982156E
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 01:16:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="RfrCQyZ7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D0982156E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=akamai.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391734AbeIVHHv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 03:07:51 -0400
Received: from mx0b-00190b01.pphosted.com ([67.231.157.127]:52314 "EHLO
        mx0b-00190b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725800AbeIVHHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 03:07:51 -0400
X-Greylist: delayed 2954 seconds by postgrey-1.27 at vger.kernel.org; Sat, 22 Sep 2018 03:07:50 EDT
Received: from pps.filterd (m0122331.ppops.net [127.0.0.1])
        by mx0b-00190b01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8M0Qkn4005439;
        Sat, 22 Sep 2018 01:27:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=jan2016.eng;
 bh=p93C1xLyqAth6U3fPGI0FLeYdTlDpiESsNqR4DBO90k=;
 b=RfrCQyZ720qgskTrrN4qIxTxX7luP9GXUmc3H74ak2QSFAsXr63ys73Z4N+TLdGt7A1F
 Zdx9OoavlBb0YbOtev8veSIwgI6VjY+vfyW4XCQhtzoRg3ePcEMcgXUxvra+JklbzDH4
 yEW37iR2b2pZhYMQRjd88CFLB6SM+4aTLyc28WrCi4rAJNGC//ShK0dKZM20cTjAIlVS
 o21yuGcYS/NwLuxlWQ+Xe0yDBxbFLwXcl5rKhtgTd9wRJIikMrH0EiBwalC39SBIHbzj
 z2yedOUQajtWJMXrW23hrRsOfkE1rJltWM7ybxxEXwepzo7edMLvnVBoqorKhemoQJry Bw== 
Received: from prod-mail-ppoint1 (prod-mail-ppoint1.akamai.com [184.51.33.18])
        by mx0b-00190b01.pphosted.com with ESMTP id 2mnakqr2dy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 22 Sep 2018 01:27:10 +0100
Received: from pps.filterd (prod-mail-ppoint1.akamai.com [127.0.0.1])
        by prod-mail-ppoint1.akamai.com (8.16.0.21/8.16.0.21) with SMTP id w8M0KXDP019601;
        Fri, 21 Sep 2018 20:27:10 -0400
Received: from prod-mail-relay11.akamai.com ([172.27.118.250])
        by prod-mail-ppoint1.akamai.com with ESMTP id 2mmkmgp58c-1;
        Fri, 21 Sep 2018 20:27:09 -0400
Received: from [0.0.0.0] (prod-ssh-gw01.bos01.corp.akamai.com [172.27.119.138])
        by prod-mail-relay11.akamai.com (Postfix) with ESMTP id 277481FC71;
        Sat, 22 Sep 2018 00:27:09 +0000 (GMT)
Subject: Re: [PATCH 00/22] various dynamic_debug patches
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        netdev@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-btrfs@vger.kernel.org, linux-acpi@vger.kernel.org,
        x86@kernel.org
References: <20180919220444.23190-1-linux@rasmusvillemoes.dk>
From:   Jason Baron <jbaron@akamai.com>
Message-ID: <b2976966-8c48-2798-b2d6-cf7be45ed25f@akamai.com>
Date:   Fri, 21 Sep 2018 20:27:09 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180919220444.23190-1-linux@rasmusvillemoes.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-21_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=995
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809220002
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-21_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1807170000
 definitions=main-1809220003
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/19/2018 06:04 PM, Rasmus Villemoes wrote:
> This started as an experiment to see how hard it would be to change
> the four pointers in struct _ddebug into relative offsets, a la
> CONFIG_GENERIC_BUG_RELATIVE_POINTERS, thus saving 16 bytes per
> pr_debug site (and thus exactly making up for the extra space used by
> the introduction of jump labels in 9049fc74). I stumbled on a few
> things that are probably worth fixing regardless of whether the latter
> half of this series is deemed worthwhile.
> 
> Patch relationships: 1-2, 3-4, 5-6 and 15-16 can be applied
> individually, though 2, 4 and 6 probably makes most sense in the
> context of the final goal of the series.
> 
> 7-12 I believe make sense on their own. Patch 13 again only makes
> sense if we go all the way, and 14 and 17 depend on 13.
> 
> 18-21 are more preparatory patches, and finally 22 switch over x86-64
> to use CONFIG_DYNAMIC_DEBUG_RELATIVE_POINTERS. I've tested that the
> end result boots under virtme and that the dynamic_debug control file
> has the expected contents.
> 

I would like to to see all these patches included. Feel free to add:
Acked-by: Jason Baron <jbaron@akamai.com>

I've been wanting to add DYNAMIC_DEBUG_BRANCH to the
[dev,net,pr].*ratelimited functions. That should reduce the size of the
text as well.

Thanks,

-Jason
