Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+gTV16g3jA/YA9bu44DhGeLaGSsUqcrQIIThPJG5Q6ru823Ml+YuN33XkEUDYdeuOwyLDh
ARC-Seal: i=1; a=rsa-sha256; t=1523021137; cv=none;
        d=google.com; s=arc-20160816;
        b=oTzUu3mJH8QW4reBZDy/7t+7McKnm8wAndkgfsstDUDTIyJbKLy/QtLzbHzejZmsk9
         wJCyt4psaDdhPrfF0uFhKQiZvQQDnBcqth+17TTBtPHc0XS5LZaIWqAn3QDSzdUrFKn8
         4Y05sMXwR4FyPXjPmZ11dlzYq8O6Bf9WP8+Zp5W8qtqesqPmRrR8tw2EN6bJPMSq99BL
         aYGnNTB4nZHrV57diuFfFOdZVPABDj42sSzi26yieZg/RBTZnjmgGsvTojuqNrqQ6jAr
         nx8ScD9B6X3BVeh0+Fj07ErGJ2FbrsR+g/i5cBzIgRC/pUVXJVdM3pHHKcqjCQREk61f
         qGxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=kTzAeU2vnNezdBLs/65R3ihpOVh9BhYW7aClZ6MLkuY=;
        b=oK9dKsOPMbJY37CDTaBRjd6o0jeYvJaAiE+QLn8cK3IsiSDs9rwCbzzfUCmdiatPQA
         vluJxvDR9mPK1iAptNbDCxzwofb3uKKe+jm9M5pB2PtJEHODcrE6NaUsI1gaBfpQmi9y
         q3/pHR7pE+/fgfKbzwxDqwfU/FPNAFiwbuvQspgdBVa8mmscAftzzGLqWw3k4xH3LARR
         jFs22O2xAIVIacsqq36TuV0LfCcirRWpEcqdc3oDm6CTuojPprhMGY3vKvjPgx7/rCC/
         XHfyQ4KX3KMTN2A4iIsz0uAQi4emB0TVQYugq9uV1kBna4qwfj6w85Wa9MM+eyHftXiK
         KirA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Hans de Goede <hdegoede@redhat.com>,
	Hante Meuleman <hante.meuleman@broadcom.com>,
	Pieter-Paul Giesberts <pieter-paul.giesberts@broadcom.com>,
	Franky Lin <franky.lin@broadcom.com>,
	Arend van Spriel <arend.vanspriel@broadcom.com>,
	Kalle Valo <kvalo@codeaurora.org>
Subject: [PATCH 3.18 13/93] brcmfmac: fix P2P_DEVICE ethernet address generation
Date: Fri,  6 Apr 2018 15:22:42 +0200
Message-Id: <20180406084225.537702624@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084224.918716300@linuxfoundation.org>
References: <20180406084224.918716300@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003412315746769?=
X-GMAIL-MSGID: =?utf-8?q?1597003412315746769?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arend Van Spriel <arend.vanspriel@broadcom.com>

commit 455f3e76cfc0d893585a5f358b9ddbe9c1e1e53b upstream.

The firmware has a requirement that the P2P_DEVICE address should
be different from the address of the primary interface. When not
specified by user-space, the driver generates the MAC address for
the P2P_DEVICE interface using the MAC address of the primary
interface and setting the locally administered bit. However, the MAC
address of the primary interface may already have that bit set causing
the creation of the P2P_DEVICE interface to fail with -EBUSY. Fix this
by using a random address instead to determine the P2P_DEVICE address.

Cc: stable@vger.kernel.org # 3.10.y
Reported-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Hante Meuleman <hante.meuleman@broadcom.com>
Reviewed-by: Pieter-Paul Giesberts <pieter-paul.giesberts@broadcom.com>
Reviewed-by: Franky Lin <franky.lin@broadcom.com>
Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/wireless/brcm80211/brcmfmac/p2p.c |   24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

--- a/drivers/net/wireless/brcm80211/brcmfmac/p2p.c
+++ b/drivers/net/wireless/brcm80211/brcmfmac/p2p.c
@@ -460,25 +460,23 @@ static int brcmf_p2p_set_firmware(struct
  * @dev_addr: optional device address.
  *
  * P2P needs mac addresses for P2P device and interface. If no device
- * address it specified, these are derived from the primary net device, ie.
- * the permanent ethernet address of the device.
+ * address it specified, these are derived from a random ethernet
+ * address.
  */
 static void brcmf_p2p_generate_bss_mac(struct brcmf_p2p_info *p2p, u8 *dev_addr)
 {
-	struct brcmf_if *pri_ifp = p2p->bss_idx[P2PAPI_BSSCFG_PRIMARY].vif->ifp;
-	bool local_admin = false;
+	bool random_addr = false;
 
-	if (!dev_addr || is_zero_ether_addr(dev_addr)) {
-		dev_addr = pri_ifp->mac_addr;
-		local_admin = true;
-	}
+	if (!dev_addr || is_zero_ether_addr(dev_addr))
+		random_addr = true;
 
-	/* Generate the P2P Device Address.  This consists of the device's
-	 * primary MAC address with the locally administered bit set.
+	/* Generate the P2P Device Address obtaining a random ethernet
+	 * address with the locally administered bit set.
 	 */
-	memcpy(p2p->dev_addr, dev_addr, ETH_ALEN);
-	if (local_admin)
-		p2p->dev_addr[0] |= 0x02;
+	if (random_addr)
+		eth_random_addr(p2p->dev_addr);
+	else
+		memcpy(p2p->dev_addr, dev_addr, ETH_ALEN);
 
 	/* Generate the P2P Interface Address.  If the discovery and connection
 	 * BSSCFGs need to simultaneously co-exist, then this address must be
