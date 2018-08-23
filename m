Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 390FFC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:58:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0B2320847
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:58:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0B2320847
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387677AbeHWM1f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:27:35 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:53010 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728289AbeHWM1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:27:34 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id B513AC83;
        Thu, 23 Aug 2018 08:58:51 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Casey Leedom <leedom@chelsio.com>,
        Ganesh Goudar <ganeshgr@chelsio.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 205/324] cxgb4: assume flash part size to be 4MB, if it cant be determined
Date:   Thu, 23 Aug 2018 09:54:31 +0200
Message-Id: <20180823075006.397538108@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823074955.885811006@linuxfoundation.org>
References: <20180823074955.885811006@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Casey Leedom <leedom@chelsio.com>

[ Upstream commit 843789f6dd6ae1651a77ac99c13bcaf191ebe05c ]

t4_get_flash_params() fails in a fatal fashion if the FLASH part isn't
one of the recognized parts. But this leads to desperate efforts to update
drivers when various FLASH parts which we are using suddenly become
unavailable and we need to substitute new FLASH parts.  This has lead to
more than one Customer Field Emergency when a Customer has an old driver
and suddenly can't use newly shipped adapters.

This commit fixes this by simply assuming that the FLASH part is 4MB in
size if it can't be identified. Note that all Chelsio adapters will have
flash parts which are at least 4MB in size.

Signed-off-by: Casey Leedom <leedom@chelsio.com>
Signed-off-by: Ganesh Goudar <ganeshgr@chelsio.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/chelsio/cxgb4/t4_hw.c |   35 ++++++++++-------------------
 1 file changed, 13 insertions(+), 22 deletions(-)

--- a/drivers/net/ethernet/chelsio/cxgb4/t4_hw.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/t4_hw.c
@@ -8526,7 +8526,7 @@ static int t4_get_flash_params(struct ad
 	};
 
 	unsigned int part, manufacturer;
-	unsigned int density, size;
+	unsigned int density, size = 0;
 	u32 flashid = 0;
 	int ret;
 
@@ -8596,11 +8596,6 @@ static int t4_get_flash_params(struct ad
 		case 0x22: /* 256MB */
 			size = 1 << 28;
 			break;
-
-		default:
-			dev_err(adap->pdev_dev, "Micron Flash Part has bad size, ID = %#x, Density code = %#x\n",
-				flashid, density);
-			return -EINVAL;
 		}
 		break;
 	}
@@ -8616,10 +8611,6 @@ static int t4_get_flash_params(struct ad
 		case 0x17: /* 64MB */
 			size = 1 << 26;
 			break;
-		default:
-			dev_err(adap->pdev_dev, "ISSI Flash Part has bad size, ID = %#x, Density code = %#x\n",
-				flashid, density);
-			return -EINVAL;
 		}
 		break;
 	}
@@ -8635,10 +8626,6 @@ static int t4_get_flash_params(struct ad
 		case 0x18: /* 16MB */
 			size = 1 << 24;
 			break;
-		default:
-			dev_err(adap->pdev_dev, "Macronix Flash Part has bad size, ID = %#x, Density code = %#x\n",
-				flashid, density);
-			return -EINVAL;
 		}
 		break;
 	}
@@ -8654,17 +8641,21 @@ static int t4_get_flash_params(struct ad
 		case 0x18: /* 16MB */
 			size = 1 << 24;
 			break;
-		default:
-			dev_err(adap->pdev_dev, "Winbond Flash Part has bad size, ID = %#x, Density code = %#x\n",
-				flashid, density);
-			return -EINVAL;
 		}
 		break;
 	}
-	default:
-		dev_err(adap->pdev_dev, "Unsupported Flash Part, ID = %#x\n",
-			flashid);
-		return -EINVAL;
+	}
+
+	/* If we didn't recognize the FLASH part, that's no real issue: the
+	 * Hardware/Software contract says that Hardware will _*ALWAYS*_
+	 * use a FLASH part which is at least 4MB in size and has 64KB
+	 * sectors.  The unrecognized FLASH part is likely to be much larger
+	 * than 4MB, but that's all we really need.
+	 */
+	if (size == 0) {
+		dev_warn(adap->pdev_dev, "Unknown Flash Part, ID = %#x, assuming 4MB\n",
+			 flashid);
+		size = 1 << 22;
 	}
 
 	/* Store decoded Flash size and fall through into vetting code. */


