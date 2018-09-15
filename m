Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B725ECE561
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:22:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A021520882
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:22:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A021520882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727144AbeIOGjY convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 02:39:24 -0400
Received: from cmccmta3.chinamobile.com ([221.176.66.81]:23245 "EHLO
        cmccmta3.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725746AbeIOGjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:39:24 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.17]) by rmmx-syy-dmz-app10-12010 (RichMail) with SMTP id 2eea5b9c5ecc1e4-d2791; Sat, 15 Sep 2018 09:22:20 +0800 (CST)
X-RM-TRANSID: 2eea5b9c5ecc1e4-d2791
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from [10.0.0.249] (unknown[112.22.21.79])
        by rmsmtp-syy-appsvr09-12009 (RichMail) with SMTP id 2ee95b9c5eca1bc-111fb;
        Sat, 15 Sep 2018 09:22:20 +0800 (CST)
X-RM-TRANSID: 2ee95b9c5eca1bc-111fb
Content-Type: text/plain; charset=gb2312
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v2,net-next 1/2] ip_gre: fix parsing gre header in
 ipgre_err
From:   Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
In-Reply-To: <4bd44714-8190-feca-27dc-6f6b254341f8@solarflare.com>
Date:   Sat, 15 Sep 2018 09:22:19 +0800
Cc:     David Miller <davem@davemloft.net>, kuznet@ms2.inr.ac.ru,
        jbenc@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <BFA64A65-43C5-4896-A65D-552181DAEF7F@cmss.chinamobile.com>
References: <1536744082-3568-1-git-send-email-yanhaishuang@cmss.chinamobile.com>
 <20180913.105840.140151724801067072.davem@davemloft.net>
 <4bd44714-8190-feca-27dc-6f6b254341f8@solarflare.com>
To:     Edward Cree <ecree@solarflare.com>
X-Mailer: Apple Mail (2.3273)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 2018年9月14日, at 下午8:44, Edward Cree <ecree@solarflare.com> wrote:
> 
> On 13/09/18 18:58, David Miller wrote:
>> From: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
>> Date: Wed, 12 Sep 2018 17:21:21 +0800
>> 
>>> @@ -86,7 +86,7 @@ int gre_parse_header(struct sk_buff *skb, struct tnl_ptk_info *tpi,
>>> 
>>> 	options = (__be32 *)(greh + 1);
>>> 	if (greh->flags & GRE_CSUM) {
>>> -		if (skb_checksum_simple_validate(skb)) {
>>> +		if (csum_err && skb_checksum_simple_validate(skb)) {
>>> 			*csum_err = true;
>>> 			return -EINVAL;
>>> 		}
>> You want to ignore csum errors, but you do not want to elide the side
>> effects of the skb_checksum_simple_validate() call which are to set
>> skb->csum_valid and skb->csum.
>> 
>> Therefore, the skb_checksum_simple_validate() call still needs to be
>> performed. We just wont return -EINVAL in the NULL csum_err case.
> 
> How about just reversing the order of the AND?
> 
> 	if (skb_checksum_simple_validate(skb) && csum_err) {
> 		*csum_err = true;
> 		return -EINVAL;
> 	}
> 
> 

It looks good to me, thanks!

But skb_checksum_try_convert only need to be called after the checksum is 
validated, so I suggested a better solution as following:

   89                 if (!skb_checksum_simple_validate(skb)) {
   90                         skb_checksum_try_convert(skb, IPPROTO_GRE, 0,
   91                                                  null_compute_pseudo);
   92                 } else if (csum_err) {
   93                         *csum_err = true;
   94                         return -EINVAL;
   95                 }






