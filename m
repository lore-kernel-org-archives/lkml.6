Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1423546AbeE1MZw (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 08:25:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:48640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1422720AbeE1LBD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 07:01:03 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Will Newton <will.newton@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 435/496] soc: qcom: wcnss_ctrl: Fix increment in NV upload
Date: Mon, 28 May 2018 12:03:40 +0200
Message-Id: <20180528100338.057023280@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100319.498712256@linuxfoundation.org>
References: <20180528100319.498712256@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bjorn Andersson <bjorn.andersson@linaro.org>

[ Upstream commit 90c29ed7627b6b4aeb603ee197650173c8434512 ]

hdr.len includes both the size of the header and the fragment, so using
this when stepping through the firmware causes us to skip 16 bytes every
chunk of 3072 bytes; causing only the first fragment to actually be
valid data.

Instead use fragment size steps through the firmware blob.

Fixes: ea7a1f275cf0 ("soc: qcom: Introduce WCNSS_CTRL SMD client")
Reported-by: Will Newton <will.newton@gmail.com>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Andy Gross <andy.gross@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/soc/qcom/wcnss_ctrl.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/soc/qcom/wcnss_ctrl.c
+++ b/drivers/soc/qcom/wcnss_ctrl.c
@@ -249,7 +249,7 @@ static int wcnss_download_nv(struct wcns
 		/* Increment for next fragment */
 		req->seq++;
 
-		data += req->hdr.len;
+		data += NV_FRAGMENT_SIZE;
 		left -= NV_FRAGMENT_SIZE;
 	} while (left > 0);
 
