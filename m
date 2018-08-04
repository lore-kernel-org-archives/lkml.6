Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E766C4646D
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 08:08:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24591217BD
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 08:08:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GEao1q46"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24591217BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbeHDKIR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 06:08:17 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:35191 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbeHDKIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 06:08:17 -0400
Received: by mail-pl0-f67.google.com with SMTP id w3-v6so3558366plq.2
        for <linux-kernel@vger.kernel.org>; Sat, 04 Aug 2018 01:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=2JvdKO8VmQcdYiBb8qEHL6Www3f6QoSQyxdx8SFw9Jk=;
        b=GEao1q46EBRpI/PEKEJZO/eyTosJFhJYzjGej2sp+igunlcrR8zeuVW3Q1SMdj4sam
         o0Egj19G8sendC9f7enQsv+VUE93AmlRPQZjX5pMfNa6Nm08h29UmBiHzzK/Nuejdtoc
         sgj9OYGJRzhwlqCJg2VzYEUOQ5T1vvhGfW6LCPqsqUaZgaeF9sPgyEIsyDGuMkMtfrQ5
         qjzhaTwJLzxV96KfcGsFiwIVl72nRcC4Rs21Y5juxxH+Q757Zvq9g7G9obAiI6OcOaD1
         sHWiak6lRbXdX91oBb7l0Cnyop7DXz9mkdgEWPN12L9bxPOUigjlQduw06+3EZaJO+gP
         UTog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=2JvdKO8VmQcdYiBb8qEHL6Www3f6QoSQyxdx8SFw9Jk=;
        b=lulqJmMF2eyG9tdKKzOXq5w9wS9eFBZHhvOMoRYSpFH3rrWQCr+8iIvqWTp1oFFmtU
         f1wmO/LY2FrPriL+5GoLnUtUnoER4+05ChTog9pMQ51sIQ5JqjHPjkIv2xBR+1rrklt/
         zPy/PnUwjOInx5YhJ1GmvUjB7IhtS91SADJeaV6f9moopXZbTOkIi2HpzxxsmePJ/Kx4
         1qnMACyvtueSjeDnvrEE4r9U/2BIrLM7XGLWqhNmWUx2AS/mg4IO+pRmxzmPG9jHUeIs
         pkpdwUV+nacgLPHcwzFgZmMTgRIkeY+5UxZGe52FRcngRrU+b2AaE5T60kmfD3/zHESA
         ExkQ==
X-Gm-Message-State: AOUpUlEitt+UYvawcJP6e6oc9HE/Vp/MHHlA2lOslHkggP5FpQXxf/51
        ETkNLyxH05lND2ZO96E/FTo=
X-Google-Smtp-Source: AAOMgpfI/hW8nj77fevtf38Zwx/bELpy4v56QZLIZh6hOpNR3icLqu4kvvWbLPsurjs4Bb3jWMdpTg==
X-Received: by 2002:a17:902:bd07:: with SMTP id p7-v6mr6610180pls.32.1533370109138;
        Sat, 04 Aug 2018 01:08:29 -0700 (PDT)
Received: from zenus ([106.51.26.178])
        by smtp.gmail.com with ESMTPSA id b1-v6sm10119518pgi.91.2018.08.04.01.08.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 04 Aug 2018 01:08:28 -0700 (PDT)
Date:   Sat, 4 Aug 2018 13:38:22 +0530
From:   Sohil Ladhani <supertakumi86@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Kees Cook <keescook@chromium.org>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Arushi Singhal <arushisinghal19971997@gmail.com>
Cc:     "Frank A. Cancio Bello" <frank@generalsoftwareinc.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Sohil Ladhani <supertakumi86@gmail.com>
Subject: [PATCH] Staging: rtlwifi: base: Fixed line ending with parentheses
Message-ID: <20180804080817.GA2140@zenus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the "Lines should not end with a '('" problem reported by
checkpatch

Signed-off-by: Sohil Ladhani <supertakumi86@gmail.com>
---
 drivers/staging/rtlwifi/base.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtlwifi/base.c b/drivers/staging/rtlwifi/base.c
index 094827c1879a..654aa4e068ba 100644
--- a/drivers/staging/rtlwifi/base.c
+++ b/drivers/staging/rtlwifi/base.c
@@ -685,9 +685,8 @@ static void _rtl_query_protection_mode(struct ieee80211_hw *hw,
 	}
 }
 
-u8 rtl_mrate_idx_to_arfr_id(
-	struct ieee80211_hw *hw, u8 rate_index,
-	enum wireless_mode wirelessmode)
+u8 rtl_mrate_idx_to_arfr_id(struct ieee80211_hw *hw, u8 rate_index,
+			    enum wireless_mode wirelessmode)
 {
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	struct rtl_phy *rtlphy = &rtlpriv->phy;
-- 
2.18.0

