Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+8bGAObWg7Go+XCu4aaTXKXXx3gARNVJ1Y3EkD/TYSzazNXCWro2CsmsiCBMDiRmpZoSF0
ARC-Seal: i=1; a=rsa-sha256; t=1524652853; cv=none;
        d=google.com; s=arc-20160816;
        b=aGT5yW/VO98rl2lqMSfkGajcmIiCtYpNCOQQGW6XfZ98i65t+3cp59jlcdP3pGFwbH
         LDkFUFPx09vP5Ts5BrqiEB8Lk7teoRKI1PQiPVqVGR7rPQaDRTsKDEUd7HF9bCZfiOjh
         UnMAQn1QigIyYSRT6CnaJCZ87WnWK99b1cVlhQh9cptWm6wb2PPxWJ9g3de9qJgva2QO
         1C331BvwjaDwumM48lPAJWZ7kFtvUAI0ov50pQUEWCrwFi9UVx3H460eI6wZFOa3Dedu
         NzOqt8Kt8+wXXT4ZfQv1SgwGsqRsfYm7RA2a+1VNLLEMnKEfPUm5XVY2m8f/FgV7/bfK
         Q00g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=jNC1waNKdtsdqBi8bqmFZPygt2S4YvYHgjdGPnEynlM=;
        b=EvVgqJzQnzh23L3rbjxLcOHSCs6ohaRCmLtGmuPFrargrUYrfvzBx3XVH+/l4CjDUo
         rL78BD6ImXpj5FiuqzJtDvHahPsSqG8BwPsyA6TIYc2OcXDx5rJi8V7kTM6AtQKrxSzR
         9B6QgzOyKdr09f2DYQ7mf8EqG9KeM2qKzeCDg2M+8x/yquODiaBd6EIarpZiejfk3kVO
         uckbN54v8x4Of8xXo7jtcanG80E3HdIxdSO9jFInaq1oSpD6W7Khopapc6rfEwv+fHEx
         +ivx4uStVVMM5jwuMNlEGCX8Z5r4BNnOP1Go0DfxTnjzldOTgVMPRnHOClpll2iSX29B
         Dlzg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Emil Tantilov <emil.s.tantilov@intel.com>,
	Andrew Bowers <andrewx.bowers@intel.com>,
	Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 093/183] ixgbe: dont set RXDCTL.RLPML for 82599
Date: Wed, 25 Apr 2018 12:35:13 +0200
Message-Id: <20180425103246.216275044@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103242.532713678@linuxfoundation.org>
References: <20180425103242.532713678@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598714391155223486?=
X-GMAIL-MSGID: =?utf-8?q?1598714391155223486?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Emil Tantilov <emil.s.tantilov@intel.com>


[ Upstream commit 2bafa8fac19a31ca72ae1a3e48df35f73661dbed ]

commit 2de6aa3a666e ("ixgbe: Add support for padding packet")

Uses RXDCTL.RLPML to limit the maximum frame size on Rx when using
build_skb. Unfortunately that register does not work on 82599.

Added an explicit check to avoid setting this register on 82599 MAC.

Extended the comment related to the setting of RXDCTL.RLPML to better
explain its purpose.

Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -3987,11 +3987,15 @@ void ixgbe_configure_rx_ring(struct ixgb
 		rxdctl &= ~0x3FFFFF;
 		rxdctl |=  0x080420;
 #if (PAGE_SIZE < 8192)
-	} else {
+	/* RXDCTL.RLPML does not work on 82599 */
+	} else if (hw->mac.type != ixgbe_mac_82599EB) {
 		rxdctl &= ~(IXGBE_RXDCTL_RLPMLMASK |
 			    IXGBE_RXDCTL_RLPML_EN);
 
-		/* Limit the maximum frame size so we don't overrun the skb */
+		/* Limit the maximum frame size so we don't overrun the skb.
+		 * This can happen in SRIOV mode when the MTU of the VF is
+		 * higher than the MTU of the PF.
+		 */
 		if (ring_uses_build_skb(ring) &&
 		    !test_bit(__IXGBE_RX_3K_BUFFER, &ring->state))
 			rxdctl |= IXGBE_MAX_2K_FRAME_BUILD_SKB |
