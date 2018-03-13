Return-Path: <kernel-hardening-return-12515-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELueinBomiNoh/Zo+Y4x7OohZSV2fhgUWMo2I7NJP9UmS9GVfumiABSJpWClLfr6TOWGFO9S
ARC-Seal: i=1; a=rsa-sha256; t=1520970672; cv=none;
        d=google.com; s=arc-20160816;
        b=H/n0/vvajqbTnI3ggj1EfQJOl2N40NmMmm7dhkUCGVVcHFlRVp+snwneYnQGPQALtd
         5OElG6eMFrtZFcKXQbBj6W1dIBhg5VXKZgiOYcqFISVPW112qqferRS8jLqvW014xo1r
         OUqM7lUQz5LD0IdQav+CVkyQIaauR7Pb0cW17zTxPrKDdfhH4flwDWH3AYDstPNabUfE
         k6Aq400jUo2LasOePkpKKk4cxZ06wIJsgcvI0hOMJDuDhxTxCrKNioLbDhz96GQzJUkB
         ZyNJmZypx34D8qi5s2vEfPwcTPRg0bLWrVQpyeoCAyvFoBqOT9SUw8DB9ZsgeGG4CRnz
         7MQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature:delivered-to
         :list-id:list-subscribe:list-unsubscribe:list-help:list-post
         :precedence:mailing-list:arc-authentication-results;
        bh=kAZx9DFIAm0eV3zHFogGRnY2Cp5kqjv02JdW5cXaKok=;
        b=SoeKPmC2U5mIMBX7o5rbSIbSyvqdvSl3rpy+2jfkisfiClfz/ajg/ZYjuRhep3uRnb
         PCMVLYz1lYZ26xHMcFN66iJlKWgzMHOXlmHbZb+xH17fInZ0CsL8sk3qJWk0viBu5Yzr
         mZl020KGqmtCYpaXVIBToECk10wA46Sy2rQUOawVB3+j6mGCVRWIkUlOdlv78LSsgUU1
         CNSnd3qCpfbgZURQiiD5+JwQjitl3+y6vtS2Vji/jAKILctxPtjoJ3zog7ms73M+1k1U
         S5HHROKKcD4WV8OOLNKoH73wHWaog1/fSRPUoaB6ezffca/cLeZGEEhOJB7q6v1qnUcn
         ebNQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=HTGsgeG0;
       spf=pass (google.com: domain of kernel-hardening-return-12515-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12515-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=HTGsgeG0;
       spf=pass (google.com: domain of kernel-hardening-return-12515-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12515-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
From: Salvatore Mesoraca <s.mesoraca16@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: kernel-hardening@lists.openwall.com,
	netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Kees Cook <keescook@chromium.org>,
	Salvatore Mesoraca <s.mesoraca16@gmail.com>,
	Vivien Didelot <vivien.didelot@savoirfairelinux.com>
Subject: [PATCH] net: dsa: drop some VLAs in switch.c
Date: Tue, 13 Mar 2018 20:50:47 +0100
Message-Id: <1520970647-19587-1-git-send-email-s.mesoraca16@gmail.com>
X-Mailer: git-send-email 1.9.1
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594853343808183482?=
X-GMAIL-MSGID: =?utf-8?q?1594853343808183482?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

dsa_switch's num_ports is currently fixed to DSA_MAX_PORTS. So we avoid
2 VLAs[1] by using DSA_MAX_PORTS instead of ds->num_ports.

[1] https://lkml.org/lkml/2018/3/7/621

Signed-off-by: Salvatore Mesoraca <s.mesoraca16@gmail.com>
---
 net/dsa/switch.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/dsa/switch.c b/net/dsa/switch.c
index b935117..78e9897 100644
--- a/net/dsa/switch.c
+++ b/net/dsa/switch.c
@@ -136,7 +136,7 @@ static int dsa_switch_mdb_add(struct dsa_switch *ds,
 {
 	const struct switchdev_obj_port_mdb *mdb = info->mdb;
 	struct switchdev_trans *trans = info->trans;
-	DECLARE_BITMAP(group, ds->num_ports);
+	DECLARE_BITMAP(group, DSA_MAX_PORTS);
 	int port;
 
 	/* Build a mask of Multicast group members */
@@ -204,7 +204,7 @@ static int dsa_switch_vlan_add(struct dsa_switch *ds,
 {
 	const struct switchdev_obj_port_vlan *vlan = info->vlan;
 	struct switchdev_trans *trans = info->trans;
-	DECLARE_BITMAP(members, ds->num_ports);
+	DECLARE_BITMAP(members, DSA_MAX_PORTS);
 	int port;
 
 	/* Build a mask of VLAN members */
-- 
1.9.1
