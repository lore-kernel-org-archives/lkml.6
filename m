Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B074C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 15:53:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFDFF2084A
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 15:53:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFDFF2084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728124AbeH1TpR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 15:45:17 -0400
Received: from mail-oi0-f53.google.com ([209.85.218.53]:37240 "EHLO
        mail-oi0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbeH1TpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 15:45:16 -0400
Received: by mail-oi0-f53.google.com with SMTP id p84-v6so3731404oic.4;
        Tue, 28 Aug 2018 08:53:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dmsFnFa+rHwaIKyMDWAR6JB4IObSHfoKE8CK74MJYsk=;
        b=MYFVIew10BUp/QoJT2Dzn+3YGHVteI0B9miV/D6fpGPhIBpQatEpvx+GKwhXiqCIXv
         J9wtF+QUEGAdzyAY1HmTUPOJarNsy5fi5p0uflXna54+a1kP+WzWFRlFyj0v3O/llEle
         1hFrXBxO4gDddt3FFUykoKU8iX2qmcdQhPBpdqA8Q6DbdHcg7en8+2Ggrb5wDcRyC44o
         Q2EbM0CXnIW8GE679wGgQ3Rrmc+BHXwfZknaE/jtPTUILaNO7n7Sa544X9Wu2sELu093
         gS2eCJtcE8CDtwxxQ4KWofRFmumEbtzQYtd3qvQZ0V7IPf7VGmagOdgq85yuyPUqRnes
         YR7w==
X-Gm-Message-State: APzg51Da1RBT1LyBUAOlOb9oHpE/ltCZMIFXL2DSHdPqmiLbPkKP1wyv
        5TMOes4CjlMsgJJirPGpnRa83tE=
X-Google-Smtp-Source: ANB0VdYiPhu76iXLtCH0V4anv802fno7BsIFyytTaaLp1VA42DEcThzNTMjpmedQiTn6DFe6a6E1tw==
X-Received: by 2002:aca:2111:: with SMTP id 17-v6mr1572408oiz.241.1535471579756;
        Tue, 28 Aug 2018 08:52:59 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id o68-v6sm2902294oik.56.2018.08.28.08.52.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Aug 2018 08:52:58 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] vsprintf: print OF node name using full_name
Date:   Tue, 28 Aug 2018 10:52:54 -0500
Message-Id: <20180828155254.10709-5-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180828155254.10709-1-robh@kernel.org>
References: <20180828155254.10709-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to remove the node name pointer from struct device_node,
convert the node name print to get the node name from the full name.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 lib/vsprintf.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index d5b3a3f95c01..891c282092a0 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -1596,6 +1596,7 @@ char *device_node_string(char *buf, char *end, struct device_node *dn,
 		fmt = "f";
 
 	for (pass = false; strspn(fmt,"fnpPFcC"); fmt++, pass = true) {
+		int precision;
 		if (pass) {
 			if (buf < end)
 				*buf = ':';
@@ -1607,7 +1608,11 @@ char *device_node_string(char *buf, char *end, struct device_node *dn,
 			buf = device_node_gen_full_name(dn, buf, end);
 			break;
 		case 'n':	/* name */
-			buf = string(buf, end, dn->name, str_spec);
+			p = kbasename(of_node_full_name(dn));
+			precision = str_spec.precision;
+			str_spec.precision = strchrnul(p, '@') - p;
+			buf = string(buf, end, p, str_spec);
+			str_spec.precision = precision;
 			break;
 		case 'p':	/* phandle */
 			buf = number(buf, end, (unsigned int)dn->phandle, num_spec);
-- 
2.17.1

