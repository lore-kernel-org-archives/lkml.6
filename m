Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49xLT7K8myG49WzGVHDuaxR27ne2MeKXRUGhj0Eq+NtZIW9nnU82weJ0zbyEoA5CGq3oYRx
ARC-Seal: i=1; a=rsa-sha256; t=1522168315; cv=none;
        d=google.com; s=arc-20160816;
        b=qYcfX5yIMg97WDgdibfmo3gfmcN3+jJVVlBMLE7AZjbO6CGi58NjuKtONJwWO5o7Gg
         cAAJ62Xkip8El71riofws+wBucZ3TtBoYjiVskZRFI0zO+CFr1F5aPYCqdoStBmdAgse
         mI1R4Dy7Jgii3Sp1rgpOlYIOodH6kVjV1lZcmADcq+H9Ur6tN+znxZv08EWGZH1R5gCg
         BFfIO4ofl2Q/53Qk+frpR8ZM5uonVu9MVqtBewfu73K4Tz6yLWPDpNgLetrywXwiUoOA
         HiCe97B9tJIfXQYUeKBZu5tHzVRcewxmNYnkhCOXNFrC++YJFms1rM6NtNrLA2h9uYv4
         fqjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=VzgNppc62vdL6044+AYs4fLIczRaMeiHF8M7rSD5aKg=;
        b=TdZYRjUT98nKHdqyOX4OKeSfADC/KV0elefXO8wxryxYmRWUfyOa3a0H3lKj+dGV3+
         SLJRRTmYz56jfAOA7e9s/DFuj4PzUZ3eoPWP0wjsoLcjJ/0+CTJivutkNOrWz7+iculb
         JgdqEbns048PXGFwDVSsGPNgbqynk23Sq5nBPiNuiHT5JnwaGxXML3LbzQYxxtpvgztE
         PUxCku/Bys88w45wq7mlOOh5MSV+hoWIAJVHCR5Zv7v+Xm2EW2warT4OgOgT8CkA1k9v
         GrCqqv0gbkppo2w9kqv54wzaIOyNBKRm3Wn/x7wk+ASYFSSgBVQ8eOnEtnZIg+3E8VvV
         L+Yg==
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
Subject: [PATCH 4.9 35/67] brcmfmac: fix P2P_DEVICE ethernet address generation
Date: Tue, 27 Mar 2018 18:27:27 +0200
Message-Id: <20180327162728.938843300@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162726.702411083@linuxfoundation.org>
References: <20180327162726.702411083@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109009231297608?=
X-GMAIL-MSGID: =?utf-8?q?1596109163412207955?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c |   24 +++++++----------
 1 file changed, 11 insertions(+), 13 deletions(-)

--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
@@ -462,25 +462,23 @@ static int brcmf_p2p_set_firmware(struct
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
