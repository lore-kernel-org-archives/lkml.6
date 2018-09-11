Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 965D8C43143
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 02:19:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF79020839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 02:19:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF79020839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbeIKHQg convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 03:16:36 -0400
Received: from cmccmta3.chinamobile.com ([221.176.66.81]:43622 "EHLO
        cmccmta3.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726182AbeIKHQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 03:16:36 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.19]) by rmmx-syy-dmz-app09-12009 (RichMail) with SMTP id 2ee95b97263582c-6837c; Tue, 11 Sep 2018 10:19:33 +0800 (CST)
X-RM-TRANSID: 2ee95b97263582c-6837c
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from [172.16.200.163] (unknown[112.25.154.148])
        by rmsmtp-syy-appsvr10-12010 (RichMail) with SMTP id 2eea5b97263374e-044ee;
        Tue, 11 Sep 2018 10:19:33 +0800 (CST)
X-RM-TRANSID: 2eea5b97263374e-044ee
Content-Type: text/plain; charset=gb2312
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] ip6_gre: simplify gre header parsing in ip6gre_err
From:   Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
In-Reply-To: <20180910173640.117bf42f@redhat.com>
Date:   Tue, 11 Sep 2018 10:19:31 +0800
Cc:     "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <F6F07B41-345D-4416-B9C7-D5509715D33F@cmss.chinamobile.com>
References: <1536567909-25089-1-git-send-email-yanhaishuang@cmss.chinamobile.com>
 <20180910173640.117bf42f@redhat.com>
To:     Jiri Benc <jbenc@redhat.com>
X-Mailer: Apple Mail (2.3273)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 2018年9月10日, at 下午11:36, Jiri Benc <jbenc@redhat.com> wrote:
> 
> On Mon, 10 Sep 2018 16:25:09 +0800, Haishuang Yan wrote:
>> +	if (gre_parse_header(skb, &tpi, &csum_err, htons(ETH_P_IPV6),
>> +			     offset) < 0) {
>> +		if (!csum_err)		/* ignore csum errors. */
>> +			return;
>> 	}
> 
> gre_parse_header stops parsing when csum_err is encountered. Which
> means tpi.key is undefined...
> 
>> 
>> -	if (!pskb_may_pull(skb, offset + grehlen))
>> -		return;
>> 	ipv6h = (const struct ipv6hdr *)skb->data;
>> -	greh = (const struct gre_base_hdr *)(skb->data + offset);
>> -	key = key_off ? *(__be32 *)(skb->data + key_off) : 0;
>> -
>> 	t = ip6gre_tunnel_lookup(skb->dev, &ipv6h->daddr, &ipv6h->saddr,
>> -				 key, greh->protocol);
>> +				 tpi.key, tpi.proto);
> 
> ...and can't be used here.
> 
> Jiri
> 

You are right. Thanks for reviewing. So the same problem also arise in ipgre_err code:

   187         iph = (const struct iphdr *)(icmp_hdr(skb) + 1);
   188         t = ip_tunnel_lookup(itn, skb->dev->ifindex, tpi->flags,
   189                              iph->daddr, iph->saddr, tpi->key);

Since csum_err may not be used outside, how about refactoring gre_parse_header function like this:

--- a/net/ipv4/gre_demux.c
+++ b/net/ipv4/gre_demux.c
@@ -86,7 +86,7 @@ int gre_parse_header(struct sk_buff *skb, struct tnl_ptk_info *tpi,

        options = (__be32 *)(greh + 1);
        if (greh->flags & GRE_CSUM) {
-               if (skb_checksum_simple_validate(skb)) {
+               if (csum_err && skb_checksum_simple_validate(skb)) {
                        *csum_err = true;
                        return -EINVAL;
                }

And in gre_err function, we can call gre_parse_header(skb, &tpi, NULL, **) like this:

--- a/net/ipv4/ip_gre.c
+++ b/net/ipv4/ip_gre.c
@@ -234,11 +234,9 @@ static void gre_err(struct sk_buff *skb, u32 info)
        struct tnl_ptk_info tpi;
        bool csum_err = false;

-       if (gre_parse_header(skb, &tpi, &csum_err, htons(ETH_P_IP),
-                            iph->ihl * 4) < 0) {
-               if (!csum_err)          /* ignore csum errors. */
+       if (gre_parse_header(skb, &tpi, NULL, htons(ETH_P_IP),
+                            iph->ihl * 4) < 0)
                        return;
-       }

