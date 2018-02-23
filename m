Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvoyyMcVYxRPxJKfRlZMrWG6QP19XDf91HMcG6doPxBoRl6HMfcd52ThuHg01FeMpTq7SXi
ARC-Seal: i=1; a=rsa-sha256; t=1519411145; cv=none;
        d=google.com; s=arc-20160816;
        b=tSBRpTsip7nDa2wv2gNSyyxN1Z0s+ONyHrqkgAq5p6tFKYJE/wkVP6oeX3RAmQygTL
         k7YCiHtQajfFrFDLgCS1hy8c2qxH4AOaf4yF4eTRhuPBKJPdj55KoR2pbo6zOrZb03Nh
         DS/cB6OOT45cKERltIF/03l0mYc3cdy1vLyjg0vy3aCHmyZXtkzUGiU4G9WuVy2+2JeR
         CJethxFnzBgau76VoBmbWLb/+Qxlxg6kKGDLUQAMMp9Y1YzW47NtHp1QufVM4+AhpQSM
         wyTqYphzHVE683Gnmheqv94tEkjJ+avYBDK/v2OGJRiHmgKwKE79gqT25Y4um5xJuEAc
         9Bzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=LpAvb3exHv9sW2myZfrb3//izbpBRPwM00Ox+H2Ekaw=;
        b=ra/atdWKebYLzFXt76v9yBz+wQnucr9fuUdPz9D/8o/F1+Te3iq2sBC+QOZCk4g0G6
         s+H6boIkEsW9QG/38T7a4E4yvL1LThepx/9D7TCHscCbwACpDoNqSpf6LdvKkW0SC+ve
         HWccXU7hsm/dSStjyEV4uJwpIvqERtDPKEw3hhvBEdkh4rncr4nLbV0rRNJ5/KtdCTMa
         wfHFAsq/9J51HGgvqnTPgaCYho/tsoviQxv9j6Y1LQrLCHWDDUMG+29X3NStIqbYhDE9
         ub5nncL0QV4qgdQmUaDN7EK29ElelSIkI6Kt9T65BWABHfgQqHgCNf+VnLitLAZeoFh/
         koLg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 136/193] ISDN: eicon: reduce stack size of sig_ind function
Date: Fri, 23 Feb 2018 19:26:09 +0100
Message-Id: <20180223170347.100101187@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593218061369111419?=
X-GMAIL-MSGID: =?utf-8?q?1593218061369111419?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit 27d807180ae0a9e50d90adf9b22573c21be904c2 upstream.

I noticed that this function uses a lot of kernel stack when the
"latent entropy" plugin is enabled:

drivers/isdn/hardware/eicon/message.c: In function 'sig_ind':
drivers/isdn/hardware/eicon/message.c:6113:1: error: the frame size of 1168 bytes is larger than 1152 bytes [-Werror=frame-larger-than=]

We currently don't warn about this, as we raise the warning limit
to 2048 bytes in mainline, but I'd like to lower that limit again
in the future, and this function can easily be changed to be more
efficient and avoid that warning, by making some of its local
variables 'const'.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/isdn/hardware/eicon/message.c |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

--- a/drivers/isdn/hardware/eicon/message.c
+++ b/drivers/isdn/hardware/eicon/message.c
@@ -147,7 +147,7 @@ static word plci_remove_check(PLCI *);
 static void listen_check(DIVA_CAPI_ADAPTER *);
 static byte AddInfo(byte **, byte **, byte *, byte *);
 static byte getChannel(API_PARSE *);
-static void IndParse(PLCI *, word *, byte **, byte);
+static void IndParse(PLCI *, const word *, byte **, byte);
 static byte ie_compare(byte *, byte *);
 static word find_cip(DIVA_CAPI_ADAPTER *, byte *, byte *);
 static word CPN_filter_ok(byte *cpn, DIVA_CAPI_ADAPTER *, word);
@@ -4860,7 +4860,7 @@ static void sig_ind(PLCI *plci)
 	/* included before the ESC_MSGTYPE and MAXPARMSIDS has to be incremented */
 	/* SMSG is situated at the end because its 0 (for compatibility reasons */
 	/* (see Info_Mask Bit 4, first IE. then the message type)           */
-	word parms_id[] =
+	static const word parms_id[] =
 		{MAXPARMSIDS, CPN, 0xff, DSA, OSA, BC, LLC, HLC, ESC_CAUSE, DSP, DT, CHA,
 		 UUI, CONG_RR, CONG_RNR, ESC_CHI, KEY, CHI, CAU, ESC_LAW,
 		 RDN, RDX, CONN_NR, RIN, NI, CAI, ESC_CR,
@@ -4868,12 +4868,12 @@ static void sig_ind(PLCI *plci)
 	/* 14 FTY repl by ESC_CHI */
 	/* 18 PI  repl by ESC_LAW */
 	/* removed OAD changed to 0xff for future use, OAD is multiIE now */
-	word multi_fac_id[] = {1, FTY};
-	word multi_pi_id[]  = {1, PI};
-	word multi_CiPN_id[]  = {1, OAD};
-	word multi_ssext_id[]  = {1, ESC_SSEXT};
+	static const word multi_fac_id[] = {1, FTY};
+	static const word multi_pi_id[]  = {1, PI};
+	static const word multi_CiPN_id[]  = {1, OAD};
+	static const word multi_ssext_id[]  = {1, ESC_SSEXT};
 
-	word multi_vswitch_id[]  = {1, ESC_VSWITCH};
+	static const word multi_vswitch_id[]  = {1, ESC_VSWITCH};
 
 	byte *cau;
 	word ncci;
@@ -8926,7 +8926,7 @@ static void listen_check(DIVA_CAPI_ADAPT
 /* functions for all parameters sent in INDs                        */
 /*------------------------------------------------------------------*/
 
-static void IndParse(PLCI *plci, word *parms_id, byte **parms, byte multiIEsize)
+static void IndParse(PLCI *plci, const word *parms_id, byte **parms, byte multiIEsize)
 {
 	word ploc;            /* points to current location within packet */
 	byte w;
