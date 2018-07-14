Return-Path: <SRS0=T5ek=J6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37CBFECDFAA
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 17:56:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C37792089F
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 17:56:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XfJSrYyD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C37792089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730922AbeGNSNG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Jul 2018 14:13:06 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43157 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726960AbeGNSNG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jul 2018 14:13:06 -0400
Received: by mail-lj1-f195.google.com with SMTP id r13-v6so26745586ljg.10
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jul 2018 10:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=KQOuc+DYmITORBezfB6EER0r+ARQxVv5t0cT64kH2dM=;
        b=XfJSrYyDTTYoqZZxsJLiXYYIowsQ/43/cmEsvMAWAb0rMM8sejPVgzVwsHXSZaE1+7
         k7PKRUL7pctjnFCER50tKFwRVQvzfjlsMoMKwwA1EGWG1ZNb99zRaBX+AH06o2+KBa5y
         eeIWets49ZjyVWMF4oEIqUOJ3YjAJt5mqHUIU5z9rZXqyBahLE9xHtRxMCMdT/gJM6uk
         HxF09itia2hNYC/JBKmoTCLE1LwXZW8EEERbRlYXzGRJ7R/Br+zUlJMEAz/JGUEOjbvD
         2TqYXa//njgbjHxLlo+HMEWWSZszu6qmGtSf3yR1v+2PBhr/+A8Wqa3uU6sHAuthwwPm
         1seg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=KQOuc+DYmITORBezfB6EER0r+ARQxVv5t0cT64kH2dM=;
        b=IQZqG20PHjO/P72frKaYQvXLO6MJn45aVSPe6mLOocGieRy2l8focvZbZxqVNX+1gz
         nr32mePMcOF6Eamxbm/haZpzI65wR8t1TpoBXTfkUMQt8NXfV/wzz5p7HYKJsC5eFz76
         RemPqTCcQD6rU1jaX89dLO1UgTt4KtGPp9hQ9nR+ULMvpLQdCbYISKdn3p4VcOV+E7c4
         jKoXvlhA36k/1dtC9iaIk3Fgx1MgMk/DlkitrZHQRTa6WhE/Qc0pjcItdPuV0YT7a+gJ
         KITHQaYNnuHHCTG1I/WXmmzOkZd9KpYVZXNVHGbF+grhNYf8E/0rNhrGwf6ESU36ph9f
         LQbA==
X-Gm-Message-State: AOUpUlEYQNIxr6adgj+ljyN938IgdO3nZJSsbEBW/YcNABj07N36DdXe
        lPY/Svkm3ZMcLObNNDlPw78=
X-Google-Smtp-Source: AAOMgpeXKN2uWnWFYzFEeLmVWztXIFp3bTs8dvrZqE3VjLdtJG34Q3aVLe+RFD56NPSrmJX01GTStQ==
X-Received: by 2002:a2e:21d5:: with SMTP id h82-v6mr6133448lji.46.1531590794836;
        Sat, 14 Jul 2018 10:53:14 -0700 (PDT)
Received: from alpha (ppp89-110-19-220.pppoe.avangarddsl.ru. [89.110.19.220])
        by smtp.gmail.com with ESMTPSA id m29-v6sm7214215lfj.45.2018.07.14.10.53.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 14 Jul 2018 10:53:14 -0700 (PDT)
Received: (nullmailer pid 24343 invoked by uid 1000);
        Sat, 14 Jul 2018 17:54:26 -0000
From:   Ivan Safonov <insafonov@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Santha Meena Ramamoorthy <santhameena13@gmail.com>,
        Michael Straube <straube.linux@gmail.com>,
        Janani Sankara Babu <jananis37@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Ivan Safonov <insafonov@gmail.com>
Subject: [PATCH 1/2] staging:r8188eu: Use lib80211 to encrypt (TKIP) tx frames
Date:   Sat, 14 Jul 2018 20:54:09 +0300
Message-Id: <20180714175410.24296-1-insafonov@gmail.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Put data to skb, decrypt with lib80211_crypt_tkip, and place back to tx buffer.

MIC calculation will be replaced later.

Signed-off-by: Ivan Safonov <insafonov@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_security.c | 419 +++++---------------------
 1 file changed, 77 insertions(+), 342 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_security.c b/drivers/staging/rtl8188eu/core/rtw_security.c
index a01290467c64..ada69efd61b3 100644
--- a/drivers/staging/rtl8188eu/core/rtw_security.c
+++ b/drivers/staging/rtl8188eu/core/rtw_security.c
@@ -12,121 +12,6 @@
 #include <osdep_intf.h>
 #include <net/lib80211.h>
 
-/* WEP related ===== */
-
-#define CRC32_POLY 0x04c11db7
-
-struct arc4context {
-	u32 x;
-	u32 y;
-	u8 state[256];
-};
-
-static void arcfour_init(struct arc4context *parc4ctx, u8 *key, u32	key_len)
-{
-	u32	t, u;
-	u32	keyindex;
-	u32	stateindex;
-	u8 *state;
-	u32	counter;
-
-	state = parc4ctx->state;
-	parc4ctx->x = 0;
-	parc4ctx->y = 0;
-	for (counter = 0; counter < 256; counter++)
-		state[counter] = (u8)counter;
-	keyindex = 0;
-	stateindex = 0;
-	for (counter = 0; counter < 256; counter++) {
-		t = state[counter];
-		stateindex = (stateindex + key[keyindex] + t) & 0xff;
-		u = state[stateindex];
-		state[stateindex] = (u8)t;
-		state[counter] = (u8)u;
-		if (++keyindex >= key_len)
-			keyindex = 0;
-	}
-}
-
-static u32 arcfour_byte(struct arc4context *parc4ctx)
-{
-	u32 x;
-	u32 y;
-	u32 sx, sy;
-	u8 *state;
-
-	state = parc4ctx->state;
-	x = (parc4ctx->x + 1) & 0xff;
-	sx = state[x];
-	y = (sx + parc4ctx->y) & 0xff;
-	sy = state[y];
-	parc4ctx->x = x;
-	parc4ctx->y = y;
-	state[y] = (u8)sx;
-	state[x] = (u8)sy;
-	return state[(sx + sy) & 0xff];
-}
-
-static void arcfour_encrypt(struct arc4context *parc4ctx, u8 *dest, u8 *src, u32 len)
-{
-	u32	i;
-
-	for (i = 0; i < len; i++)
-		dest[i] = src[i] ^ (unsigned char)arcfour_byte(parc4ctx);
-}
-
-static int bcrc32initialized;
-static u32 crc32_table[256];
-
-static u8 crc32_reverseBit(u8 data)
-{
-	return (u8)((data<<7)&0x80) | ((data<<5)&0x40) | ((data<<3)&0x20) |
-		   ((data<<1)&0x10) | ((data>>1)&0x08) | ((data>>3)&0x04) |
-		   ((data>>5)&0x02) | ((data>>7)&0x01);
-}
-
-static void crc32_init(void)
-{
-	if (bcrc32initialized == 1) {
-		return;
-	} else {
-		int i, j;
-		u32 c;
-		u8 *p = (u8 *)&c, *p1;
-		u8 k;
-
-		c = 0x12340000;
-
-		for (i = 0; i < 256; ++i) {
-			k = crc32_reverseBit((u8)i);
-			for (c = ((u32)k) << 24, j = 8; j > 0; --j)
-				c = c & 0x80000000 ? (c << 1) ^ CRC32_POLY : (c << 1);
-			p1 = (u8 *)&crc32_table[i];
-
-			p1[0] = crc32_reverseBit(p[3]);
-			p1[1] = crc32_reverseBit(p[2]);
-			p1[2] = crc32_reverseBit(p[1]);
-			p1[3] = crc32_reverseBit(p[0]);
-		}
-		bcrc32initialized = 1;
-	}
-}
-
-static __le32 getcrc32(u8 *buf, int len)
-{
-	u8 *p;
-	u32  crc;
-
-	if (bcrc32initialized == 0)
-		crc32_init();
-
-	crc = 0xffffffff;       /* preload shift register, per CRC-32 spec */
-
-	for (p = buf; len > 0; ++p, --len)
-		crc = crc32_table[(crc ^ *p) & 0xff] ^ (crc >> 8);
-	return cpu_to_le32(~crc);    /* transmit complement, per CRC-32 spec */
-}
-
 /*
 	Need to consider the fragment  situation
 */
@@ -395,202 +280,24 @@ void rtw_seccalctkipmic(u8 *key, u8 *header, u8 *data, u32 data_len, u8 *mic_cod
 #define P1K_SIZE	 10    /*  80-bit Phase1 key		*/
 #define RC4_KEY_SIZE     16    /* 128-bit RC4KEY (104 bits unknown) */
 
-/* 2-unsigned char by 2-unsigned char subset of the full AES S-box table */
-static const unsigned short Sbox1[2][256] = {  /* Sbox for hash (can be in ROM)     */
-{
-	0xC6A5, 0xF884, 0xEE99, 0xF68D, 0xFF0D, 0xD6BD, 0xDEB1, 0x9154,
-	0x6050, 0x0203, 0xCEA9, 0x567D, 0xE719, 0xB562, 0x4DE6, 0xEC9A,
-	0x8F45, 0x1F9D, 0x8940, 0xFA87, 0xEF15, 0xB2EB, 0x8EC9, 0xFB0B,
-	0x41EC, 0xB367, 0x5FFD, 0x45EA, 0x23BF, 0x53F7, 0xE496, 0x9B5B,
-	0x75C2, 0xE11C, 0x3DAE, 0x4C6A, 0x6C5A, 0x7E41, 0xF502, 0x834F,
-	0x685C, 0x51F4, 0xD134, 0xF908, 0xE293, 0xAB73, 0x6253, 0x2A3F,
-	0x080C, 0x9552, 0x4665, 0x9D5E, 0x3028, 0x37A1, 0x0A0F, 0x2FB5,
-	0x0E09, 0x2436, 0x1B9B, 0xDF3D, 0xCD26, 0x4E69, 0x7FCD, 0xEA9F,
-	0x121B, 0x1D9E, 0x5874, 0x342E, 0x362D, 0xDCB2, 0xB4EE, 0x5BFB,
-	0xA4F6, 0x764D, 0xB761, 0x7DCE, 0x527B, 0xDD3E, 0x5E71, 0x1397,
-	0xA6F5, 0xB968, 0x0000, 0xC12C, 0x4060, 0xE31F, 0x79C8, 0xB6ED,
-	0xD4BE, 0x8D46, 0x67D9, 0x724B, 0x94DE, 0x98D4, 0xB0E8, 0x854A,
-	0xBB6B, 0xC52A, 0x4FE5, 0xED16, 0x86C5, 0x9AD7, 0x6655, 0x1194,
-	0x8ACF, 0xE910, 0x0406, 0xFE81, 0xA0F0, 0x7844, 0x25BA, 0x4BE3,
-	0xA2F3, 0x5DFE, 0x80C0, 0x058A, 0x3FAD, 0x21BC, 0x7048, 0xF104,
-	0x63DF, 0x77C1, 0xAF75, 0x4263, 0x2030, 0xE51A, 0xFD0E, 0xBF6D,
-	0x814C, 0x1814, 0x2635, 0xC32F, 0xBEE1, 0x35A2, 0x88CC, 0x2E39,
-	0x9357, 0x55F2, 0xFC82, 0x7A47, 0xC8AC, 0xBAE7, 0x322B, 0xE695,
-	0xC0A0, 0x1998, 0x9ED1, 0xA37F, 0x4466, 0x547E, 0x3BAB, 0x0B83,
-	0x8CCA, 0xC729, 0x6BD3, 0x283C, 0xA779, 0xBCE2, 0x161D, 0xAD76,
-	0xDB3B, 0x6456, 0x744E, 0x141E, 0x92DB, 0x0C0A, 0x486C, 0xB8E4,
-	0x9F5D, 0xBD6E, 0x43EF, 0xC4A6, 0x39A8, 0x31A4, 0xD337, 0xF28B,
-	0xD532, 0x8B43, 0x6E59, 0xDAB7, 0x018C, 0xB164, 0x9CD2, 0x49E0,
-	0xD8B4, 0xACFA, 0xF307, 0xCF25, 0xCAAF, 0xF48E, 0x47E9, 0x1018,
-	0x6FD5, 0xF088, 0x4A6F, 0x5C72, 0x3824, 0x57F1, 0x73C7, 0x9751,
-	0xCB23, 0xA17C, 0xE89C, 0x3E21, 0x96DD, 0x61DC, 0x0D86, 0x0F85,
-	0xE090, 0x7C42, 0x71C4, 0xCCAA, 0x90D8, 0x0605, 0xF701, 0x1C12,
-	0xC2A3, 0x6A5F, 0xAEF9, 0x69D0, 0x1791, 0x9958, 0x3A27, 0x27B9,
-	0xD938, 0xEB13, 0x2BB3, 0x2233, 0xD2BB, 0xA970, 0x0789, 0x33A7,
-	0x2DB6, 0x3C22, 0x1592, 0xC920, 0x8749, 0xAAFF, 0x5078, 0xA57A,
-	0x038F, 0x59F8, 0x0980, 0x1A17, 0x65DA, 0xD731, 0x84C6, 0xD0B8,
-	0x82C3, 0x29B0, 0x5A77, 0x1E11, 0x7BCB, 0xA8FC, 0x6DD6, 0x2C3A,
-  },
-
-  {  /* second half of table is unsigned char-reversed version of first! */
-	0xA5C6, 0x84F8, 0x99EE, 0x8DF6, 0x0DFF, 0xBDD6, 0xB1DE, 0x5491,
-	0x5060, 0x0302, 0xA9CE, 0x7D56, 0x19E7, 0x62B5, 0xE64D, 0x9AEC,
-	0x458F, 0x9D1F, 0x4089, 0x87FA, 0x15EF, 0xEBB2, 0xC98E, 0x0BFB,
-	0xEC41, 0x67B3, 0xFD5F, 0xEA45, 0xBF23, 0xF753, 0x96E4, 0x5B9B,
-	0xC275, 0x1CE1, 0xAE3D, 0x6A4C, 0x5A6C, 0x417E, 0x02F5, 0x4F83,
-	0x5C68, 0xF451, 0x34D1, 0x08F9, 0x93E2, 0x73AB, 0x5362, 0x3F2A,
-	0x0C08, 0x5295, 0x6546, 0x5E9D, 0x2830, 0xA137, 0x0F0A, 0xB52F,
-	0x090E, 0x3624, 0x9B1B, 0x3DDF, 0x26CD, 0x694E, 0xCD7F, 0x9FEA,
-	0x1B12, 0x9E1D, 0x7458, 0x2E34, 0x2D36, 0xB2DC, 0xEEB4, 0xFB5B,
-	0xF6A4, 0x4D76, 0x61B7, 0xCE7D, 0x7B52, 0x3EDD, 0x715E, 0x9713,
-	0xF5A6, 0x68B9, 0x0000, 0x2CC1, 0x6040, 0x1FE3, 0xC879, 0xEDB6,
-	0xBED4, 0x468D, 0xD967, 0x4B72, 0xDE94, 0xD498, 0xE8B0, 0x4A85,
-	0x6BBB, 0x2AC5, 0xE54F, 0x16ED, 0xC586, 0xD79A, 0x5566, 0x9411,
-	0xCF8A, 0x10E9, 0x0604, 0x81FE, 0xF0A0, 0x4478, 0xBA25, 0xE34B,
-	0xF3A2, 0xFE5D, 0xC080, 0x8A05, 0xAD3F, 0xBC21, 0x4870, 0x04F1,
-	0xDF63, 0xC177, 0x75AF, 0x6342, 0x3020, 0x1AE5, 0x0EFD, 0x6DBF,
-	0x4C81, 0x1418, 0x3526, 0x2FC3, 0xE1BE, 0xA235, 0xCC88, 0x392E,
-	0x5793, 0xF255, 0x82FC, 0x477A, 0xACC8, 0xE7BA, 0x2B32, 0x95E6,
-	0xA0C0, 0x9819, 0xD19E, 0x7FA3, 0x6644, 0x7E54, 0xAB3B, 0x830B,
-	0xCA8C, 0x29C7, 0xD36B, 0x3C28, 0x79A7, 0xE2BC, 0x1D16, 0x76AD,
-	0x3BDB, 0x5664, 0x4E74, 0x1E14, 0xDB92, 0x0A0C, 0x6C48, 0xE4B8,
-	0x5D9F, 0x6EBD, 0xEF43, 0xA6C4, 0xA839, 0xA431, 0x37D3, 0x8BF2,
-	0x32D5, 0x438B, 0x596E, 0xB7DA, 0x8C01, 0x64B1, 0xD29C, 0xE049,
-	0xB4D8, 0xFAAC, 0x07F3, 0x25CF, 0xAFCA, 0x8EF4, 0xE947, 0x1810,
-	0xD56F, 0x88F0, 0x6F4A, 0x725C, 0x2438, 0xF157, 0xC773, 0x5197,
-	0x23CB, 0x7CA1, 0x9CE8, 0x213E, 0xDD96, 0xDC61, 0x860D, 0x850F,
-	0x90E0, 0x427C, 0xC471, 0xAACC, 0xD890, 0x0506, 0x01F7, 0x121C,
-	0xA3C2, 0x5F6A, 0xF9AE, 0xD069, 0x9117, 0x5899, 0x273A, 0xB927,
-	0x38D9, 0x13EB, 0xB32B, 0x3322, 0xBBD2, 0x70A9, 0x8907, 0xA733,
-	0xB62D, 0x223C, 0x9215, 0x20C9, 0x4987, 0xFFAA, 0x7850, 0x7AA5,
-	0x8F03, 0xF859, 0x8009, 0x171A, 0xDA65, 0x31D7, 0xC684, 0xB8D0,
-	0xC382, 0xB029, 0x775A, 0x111E, 0xCB7B, 0xFCA8, 0xD66D, 0x3A2C,
-  }
-};
-
- /*
-**********************************************************************
-* Routine: Phase 1 -- generate P1K, given TA, TK, IV32
-*
-* Inputs:
-*     tk[]      = temporal key			 [128 bits]
-*     ta[]      = transmitter's MAC address	    [ 48 bits]
-*     iv32      = upper 32 bits of IV		  [ 32 bits]
-* Output:
-*     p1k[]     = Phase 1 key			  [ 80 bits]
-*
-* Note:
-*     This function only needs to be called every 2**16 packets,
-*     although in theory it could be called every packet.
-*
-**********************************************************************
-*/
-static void phase1(u16 *p1k, const u8 *tk, const u8 *ta, u32 iv32)
-{
-	int  i;
-	/* Initialize the 80 bits of P1K[] from IV32 and TA[0..5]     */
-	p1k[0]      = Lo16(iv32);
-	p1k[1]      = Hi16(iv32);
-	p1k[2]      = Mk16(ta[1], ta[0]); /* use TA[] as little-endian */
-	p1k[3]      = Mk16(ta[3], ta[2]);
-	p1k[4]      = Mk16(ta[5], ta[4]);
-
-	/* Now compute an unbalanced Feistel cipher with 80-bit block */
-	/* size on the 80-bit block P1K[], using the 128-bit key TK[] */
-	for (i = 0; i < PHASE1_LOOP_CNT; i++) { /* Each add operation here is mod 2**16 */
-		p1k[0] += _S_(p1k[4] ^ TK16((i&1)+0));
-		p1k[1] += _S_(p1k[0] ^ TK16((i&1)+2));
-		p1k[2] += _S_(p1k[1] ^ TK16((i&1)+4));
-		p1k[3] += _S_(p1k[2] ^ TK16((i&1)+6));
-		p1k[4] += _S_(p1k[3] ^ TK16((i&1)+0));
-		p1k[4] +=  (unsigned short)i;   /* avoid "slide attacks" */
-	}
-}
-
-/*
-**********************************************************************
-* Routine: Phase 2 -- generate RC4KEY, given TK, P1K, IV16
-*
-* Inputs:
-*     tk[]      = Temporal key			 [128 bits]
-*     p1k[]     = Phase 1 output key		   [ 80 bits]
-*     iv16      = low 16 bits of IV counter	    [ 16 bits]
-* Output:
-*     rc4key[]  = the key used to encrypt the packet   [128 bits]
-*
-* Note:
-*     The value {TA, IV32, IV16} for Phase1/Phase2 must be unique
-*     across all packets using the same key TK value. Then, for a
-*     given value of TK[], this TKIP48 construction guarantees that
-*     the final RC4KEY value is unique across all packets.
-*
-* Suggested implementation optimization: if PPK[] is "overlaid"
-*     appropriately on RC4KEY[], there is no need for the final
-*     for loop below that copies the PPK[] result into RC4KEY[].
-*
-**********************************************************************
-*/
-static void phase2(u8 *rc4key, const u8 *tk, const u16 *p1k, u16 iv16)
-{
-	int  i;
-	u16 PPK[6];			/* temporary key for mixing    */
-	/* Note: all adds in the PPK[] equations below are mod 2**16	 */
-	for (i = 0; i < 5; i++)
-		PPK[i] = p1k[i];	/* first, copy P1K to PPK      */
-	PPK[5]  =  p1k[4] + iv16;	/* next,  add in IV16	  */
-
-	/* Bijective non-linear mixing of the 96 bits of PPK[0..5]	   */
-	PPK[0] +=    _S_(PPK[5] ^ TK16(0));   /* Mix key in each "round"     */
-	PPK[1] +=    _S_(PPK[0] ^ TK16(1));
-	PPK[2] +=    _S_(PPK[1] ^ TK16(2));
-	PPK[3] +=    _S_(PPK[2] ^ TK16(3));
-	PPK[4] +=    _S_(PPK[3] ^ TK16(4));
-	PPK[5] +=    _S_(PPK[4] ^ TK16(5));   /* Total # S-box lookups == 6  */
-
-	/* Final sweep: bijective, "linear". Rotates kill LSB correlations   */
-	PPK[0] +=  RotR1(PPK[5] ^ TK16(6));
-	PPK[1] +=  RotR1(PPK[0] ^ TK16(7));   /* Use all of TK[] in Phase2   */
-	PPK[2] +=  RotR1(PPK[1]);
-	PPK[3] +=  RotR1(PPK[2]);
-	PPK[4] +=  RotR1(PPK[3]);
-	PPK[5] +=  RotR1(PPK[4]);
-	/* Note: At this point, for a given key TK[0..15], the 96-bit output */
-	/*       value PPK[0..5] is guaranteed to be unique, as a function   */
-	/*       of the 96-bit "input" value   {TA, IV32, IV16}. That is, P1K  */
-	/*       is now a keyed permutation of {TA, IV32, IV16}.	       */
-
-	/* Set RC4KEY[0..3], which includes "cleartext" portion of RC4 key   */
-	rc4key[0] = Hi8(iv16);		/* RC4KEY[0..2] is the WEP IV  */
-	rc4key[1] = (Hi8(iv16) | 0x20) & 0x7F; /* Help avoid weak (FMS) keys  */
-	rc4key[2] = Lo8(iv16);
-	rc4key[3] = Lo8((PPK[5] ^ TK16(0)) >> 1);
-
-	/* Copy 96 bits of PPK[0..5] to RC4KEY[4..15]  (little-endian)       */
-	for (i = 0; i < 6; i++) {
-		rc4key[4+2*i] = Lo8(PPK[i]);
-		rc4key[5+2*i] = Hi8(PPK[i]);
-	}
-}
-
 /* The hlen isn't include the IV */
 u32	rtw_tkip_encrypt(struct adapter *padapter, u8 *pxmitframe)
-{																	/*  exclude ICV */
-	u16	pnl;
-	u32	pnh;
-	u8	rc4key[16];
-	u8   ttkey[16];
-	u8	crc[4];
+{
 	u8   hw_hdr_offset = 0;
-	struct arc4context mycontext;
 	int			curfragnum, length;
 
-	u8	*pframe, *payload, *iv, *prwskey;
-	union pn48 dot11txpn;
+	u8 *pframe;
 	struct	sta_info		*stainfo;
 	struct	pkt_attrib	 *pattrib = &((struct xmit_frame *)pxmitframe)->attrib;
 	struct	security_priv	*psecuritypriv = &padapter->securitypriv;
 	struct	xmit_priv		*pxmitpriv = &padapter->xmitpriv;
 	u32	res = _SUCCESS;
+	void *crypto_private;
+	struct sk_buff *skb;
+	u8 key[32];
+	int key_idx;
+	const int key_length = 32;
+	struct lib80211_crypto_ops *crypto_ops;
 
 	if (((struct xmit_frame *)pxmitframe)->buf_addr == NULL)
 		return _FAIL;
@@ -599,57 +306,85 @@ u32	rtw_tkip_encrypt(struct adapter *padapter, u8 *pxmitframe)
 		 (((struct xmit_frame *)pxmitframe)->pkt_offset * PACKET_OFFSET_SZ);
 	pframe = ((struct xmit_frame *)pxmitframe)->buf_addr + hw_hdr_offset;
 	/* 4 start to encrypt each fragment */
-	if (pattrib->encrypt == _TKIP_) {
-		if (pattrib->psta)
-			stainfo = pattrib->psta;
-		else
-			stainfo = rtw_get_stainfo(&padapter->stapriv, &pattrib->ra[0]);
+	if (pattrib->encrypt != _TKIP_)
+		return res;
 
-		if (stainfo != NULL) {
-			RT_TRACE(_module_rtl871x_security_c_, _drv_err_, ("%s: stainfo!= NULL!!!\n", __func__));
+	if (pattrib->psta)
+		stainfo = pattrib->psta;
+	else
+		stainfo = rtw_get_stainfo(&padapter->stapriv, &pattrib->ra[0]);
 
-			if (IS_MCAST(pattrib->ra))
-				prwskey = psecuritypriv->dot118021XGrpKey[psecuritypriv->dot118021XGrpKeyid].skey;
-			else
-				prwskey = &stainfo->dot118021x_UncstKey.skey[0];
+	if (!stainfo) {
+		RT_TRACE(_module_rtl871x_security_c_, _drv_err_, ("%s: stainfo==NULL!!!\n", __func__));
+		return _FAIL;
+	}
 
-			for (curfragnum = 0; curfragnum < pattrib->nr_frags; curfragnum++) {
-				iv = pframe+pattrib->hdrlen;
-				payload = pframe+pattrib->iv_len+pattrib->hdrlen;
+	crypto_ops = try_then_request_module(lib80211_get_crypto_ops("TKIP"), "lib80211_crypt_tkip");
 
-				GET_TKIP_PN(iv, dot11txpn);
+	if (IS_MCAST(pattrib->ra)) {
+		key_idx = psecuritypriv->dot118021XGrpKeyid;
+		memcpy(key, psecuritypriv->dot118021XGrpKey[key_idx].skey, 16);
+		memcpy(key + 16, psecuritypriv->dot118021XGrptxmickey[key_idx].skey, 16);
+	} else {
+		key_idx = 0;
+		memcpy(key, stainfo->dot118021x_UncstKey.skey, 16);
+		memcpy(key + 16, stainfo->dot11tkiptxmickey.skey, 16);
+	}
 
-				pnl = (u16)(dot11txpn.val);
-				pnh = (u32)(dot11txpn.val>>16);
-				phase1((u16 *)&ttkey[0], prwskey, &pattrib->ta[0], pnh);
-				phase2(&rc4key[0], prwskey, (u16 *)&ttkey[0], pnl);
+	if (!crypto_ops) {
+		res = _FAIL;
+		goto exit;
+	}
 
-				if ((curfragnum+1) == pattrib->nr_frags) {	/* 4 the last fragment */
-					length = pattrib->last_txcmdsz-pattrib->hdrlen-pattrib->iv_len-pattrib->icv_len;
-					RT_TRACE(_module_rtl871x_security_c_, _drv_info_,
-						 ("pattrib->iv_len=%x, pattrib->icv_len=%x\n",
-						 pattrib->iv_len, pattrib->icv_len));
-					*((__le32 *)crc) = getcrc32(payload, length);/* modified by Amy*/
-
-					arcfour_init(&mycontext, rc4key, 16);
-					arcfour_encrypt(&mycontext, payload, payload, length);
-					arcfour_encrypt(&mycontext, payload+length, crc, 4);
-				} else {
-					length = pxmitpriv->frag_len-pattrib->hdrlen-pattrib->iv_len-pattrib->icv_len;
-					*((__le32 *)crc) = getcrc32(payload, length);/* modified by Amy*/
-					arcfour_init(&mycontext, rc4key, 16);
-					arcfour_encrypt(&mycontext, payload, payload, length);
-					arcfour_encrypt(&mycontext, payload+length, crc, 4);
+	crypto_private = crypto_ops->init(key_idx);
+	if (!crypto_private) {
+		res = _FAIL;
+		goto exit;
+	}
 
-					pframe += pxmitpriv->frag_len;
-					pframe = (u8 *)round_up((size_t)(pframe), 4);
-				}
-			}
-		} else {
-			RT_TRACE(_module_rtl871x_security_c_, _drv_err_, ("%s: stainfo==NULL!!!\n", __func__));
+	if (crypto_ops->set_key(key, key_length, NULL, crypto_private) < 0) {
+		res = _FAIL;
+		goto exit_crypto_ops_deinit;
+	}
+
+	RT_TRACE(_module_rtl871x_security_c_, _drv_err_, ("%s: stainfo!= NULL!!!\n", __func__));
+
+	for (curfragnum = 0; curfragnum < pattrib->nr_frags; curfragnum++) {
+		if ((curfragnum+1) == pattrib->nr_frags)
+			length = pattrib->last_txcmdsz;
+		else
+			length = pxmitpriv->frag_len;
+
+		skb = dev_alloc_skb(length);
+		if (!skb) {
+			res = _FAIL;
+			goto exit_crypto_ops_deinit;
+		}
+
+		skb_put_data(skb, pframe, length);
+
+		memmove(skb->data + pattrib->iv_len, skb->data, pattrib->hdrlen);
+		skb_pull(skb, pattrib->iv_len);
+		skb_trim(skb, skb->len - pattrib->icv_len);
+
+		if (crypto_ops->encrypt_mpdu(skb, pattrib->hdrlen, crypto_private)) {
+			kfree_skb(skb);
 			res = _FAIL;
+			goto exit_crypto_ops_deinit;
 		}
+
+		memcpy(pframe, skb->data, skb->len);
+
+		pframe += skb->len;
+		pframe = (u8 *)round_up((size_t)(pframe), 4);
+
+		kfree_skb(skb);
 	}
+
+exit_crypto_ops_deinit:
+	crypto_ops->deinit(crypto_private);
+
+exit:
 	return res;
 }
 
-- 
2.16.4

