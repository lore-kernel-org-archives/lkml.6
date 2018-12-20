Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA996C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:30:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5F5120989
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545298249;
	bh=fvY5U8LNYFcSkUC8HABJtu3zQ+2XR/vLM24Faj6DaMQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xcNf6Q2LNmnlWf1LP2/AEQREsdeeAXDuUVdZLJNqfHan0pXpLzfOCMtJKwAj3ZuKf
	 oAVjdfg60QjDxHgqAJq5juLPAVW6l62Sr+nyVf81NiHb1AYZNs0X3QetxH3EgJHb3K
	 obbZAx2NolBjzov7caBm4ey6I4TK1g0TVRSQ4YUM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733003AbeLTJas (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 04:30:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:40508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732983AbeLTJan (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 04:30:43 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 12F632186A;
        Thu, 20 Dec 2018 09:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545298242;
        bh=fvY5U8LNYFcSkUC8HABJtu3zQ+2XR/vLM24Faj6DaMQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OhJBhvxmbOTvf9Q93dxhZveswfZkmVvxFZbFcvdhycKkaSc2SmPYE8y+4PC9P8jv/
         t8S73CUpTEnMpc59o63F5BGC1h5+uxyMhDEKM2pcN96nne/y0U2mumkKyuwjFyp3LF
         yTrTlcVfEVd+DO/hndllEdPOoYAwEuvJzkCwx8f8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Russell King <rmk+kernel@armlinux.org.uk>,
        Eduardo Valentin <edubezval@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 51/67] thermal: armada: fix legacy validity test sense
Date:   Thu, 20 Dec 2018 10:19:03 +0100
Message-Id: <20181220085905.566876810@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181220085903.562090333@linuxfoundation.org>
References: <20181220085903.562090333@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 70bb27b79adf63ea39e37371d09c823c7a8f93ce ]

Commit 8c0e64ac4075 ("thermal: armada: get rid of the ->is_valid()
pointer") removed the unnecessary indirection through a function
pointer, but in doing so, also removed the negation operator too:

-       if (priv->data->is_valid && !priv->data->is_valid(priv)) {
+       if (armada_is_valid(priv)) {

which results in:

armada_thermal f06f808c.thermal: Temperature sensor reading not valid
armada_thermal f2400078.thermal: Temperature sensor reading not valid
armada_thermal f4400078.thermal: Temperature sensor reading not valid

at boot, or whenever the "temp" sysfs file is read.  Replace the
negation operator.

Fixes: 8c0e64ac4075 ("thermal: armada: get rid of the ->is_valid() pointer")
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/thermal/armada_thermal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armada_thermal.c
index 2c2f6d93034e..e16b3cb1808c 100644
--- a/drivers/thermal/armada_thermal.c
+++ b/drivers/thermal/armada_thermal.c
@@ -357,7 +357,7 @@ static int armada_get_temp_legacy(struct thermal_zone_device *thermal,
 	int ret;
 
 	/* Valid check */
-	if (armada_is_valid(priv)) {
+	if (!armada_is_valid(priv)) {
 		dev_err(priv->dev,
 			"Temperature sensor reading not valid\n");
 		return -EIO;
-- 
2.19.1



