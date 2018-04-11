Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48UMl290XVQGHFwoRwYAaCYRYXPa7xhtvF8z4O/dZytytG9bgsxr6ks3ABw7pUlMDkM3HE9
ARC-Seal: i=1; a=rsa-sha256; t=1523473270; cv=none;
        d=google.com; s=arc-20160816;
        b=Ks1Jg/Pq4rPYvySvkjyL1TMioYt/8oTo5TgtbCSLFix2kkZ2ZxZwyIhshwTIhdVSnl
         iMMOvFXfj7HKiR/YqKUrQg40H2r0I+Ewo0YCYnz0u4SWR2mxYrkjb2WgbU2wC1BrdqJB
         gAeaAJyVLZff50aYVo6/lytD+ALwRFQHI8nutPvUG8EZ3msneck0vkTWY4k86DtXN5YO
         hUOZRaJfjHpESay0pdRDPI3lecvAjUe5en0Y1H+eawA4J5TXMygbb9w3Ss8MwIKHsVIU
         GnJbghf7qtbnKIqyl0ZDm9B0RBrQ04Rju0OEy37D6/3Xb0s8nrGSGwLVT/BB+UteVlgZ
         V29w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=A9RbUiCN3RkZefTP4Gyi1AEazelAzFRQTE/O8zS1Pvg=;
        b=ldnbYiT8983yMwrm3z1ZVjWogEDbOcJJ9lrutDTjjmVNDiBQ1ba3opfUPUjoKoXoSb
         pXED6v3O67nWbl0d/5+dbWRTtLpTRifikSPS8l5gwnGSZpV6sBRMi/kqYHk73u3f8jei
         mOoLr/tCOc+mo+YGn3AnLuUuCLPTb73+X5EeEyA4dWJfQzxHKUnZwq7V0wbFlezVF/52
         ZRz0b2DLgzRCpaJK5Cyw5dowC2M6i45IUsod9gALobNdAYsyJ6bzkinXCM15aUQu43xs
         Tt5QSC5BGWWxe3KGYUC3BUlYJG1wgqNe7nDyWMH0F319NJWf8JfOj9jaXPKMWtiJfiOT
         Q2zQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Ganesh Goudar <ganeshgr@chelsio.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 186/310] cxgb4: fix incorrect cim_la output for T6
Date: Wed, 11 Apr 2018 20:35:25 +0200
Message-Id: <20180411183630.613480391@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476709278443171?=
X-GMAIL-MSGID: =?utf-8?q?1597477508715566853?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ganesh Goudar <ganeshgr@chelsio.com>


[ Upstream commit a97051f4553551d13e586ab3cb6ae13093a44a81 ]

take care of UpDbgLaRdPtr[0-3] restriction for T6.

Signed-off-by: Ganesh Goudar <ganeshgr@chelsio.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/chelsio/cxgb4/t4_hw.c |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

--- a/drivers/net/ethernet/chelsio/cxgb4/t4_hw.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/t4_hw.c
@@ -8088,7 +8088,16 @@ int t4_cim_read_la(struct adapter *adap,
 		ret = t4_cim_read(adap, UP_UP_DBG_LA_DATA_A, 1, &la_buf[i]);
 		if (ret)
 			break;
-		idx = (idx + 1) & UPDBGLARDPTR_M;
+
+		/* Bits 0-3 of UpDbgLaRdPtr can be between 0000 to 1001 to
+		 * identify the 32-bit portion of the full 312-bit data
+		 */
+		if (is_t6(adap->params.chip) && (idx & 0xf) >= 9)
+			idx = (idx & 0xff0) + 0x10;
+		else
+			idx++;
+		/* address can't exceed 0xfff */
+		idx &= UPDBGLARDPTR_M;
 	}
 restart:
 	if (cfg & UPDBGLAEN_F) {
