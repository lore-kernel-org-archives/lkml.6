Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3186171-1520946382-2-6743256626534971132
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='de', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520946382; b=UA1b7OKErtubi0Pq2zoS2Td+H72rVC0KzZTHzaRqUYa9zDZ
    7eet9yScuAFJNP9oDWksdrNnBpmNHK/9yUvgkAKZ1Hw6ZWhNykm25HMD0VxAvSTK
    am0D4q3Qm3lBMjWohjNMJyNmPBnYcSyf0c6Ha2J2Kl8gQH9qt2ynhw/YEFuf8SD0
    WXw9Z2Tn82dzJDfnx3p5ctIC2O0jVgk4TkgyuWGJI/rt/CFIpeUpHDdS1ZnObwqU
    zXiNnZkO7Rhtiovm2YFq0kMvm94FG7tINPpCS0Av9l5oIq+1tKhBMQfciLQ8wyNi
    9T/6JvqezU8UV+5RQ1nK1dArR9zLVMyZKTQxBSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520946382; bh=M
    yQRhJ/VZRg+PzDBV2NFEn+XO6relnL1Vi06AtmbWbA=; b=SYL5dNIkExbPPfjcO
    wFrUDS38n1Wg2Ai+/dVZhDU04/0J4Ke4a5+0oIExuedVD8qvGISgKOZ8Xd8Wb9nH
    w3m6yvxudQp2feUY8OYm5lGF3zvs2A92OFFOc59vr7hKoMfer2+lkmShwOVTM8F2
    rTSSfsYvHJ2zgifQK5/BaFYny0r/2uV0/Lhhob4aCgnQU7cq9HMi6H29Lj+ncQK5
    17XhsHTYsb8x8RILPeFrt/6hdydeiNDR0vW9iRY9ZgLxp9xWs8hbTB24K2vwpxwz
    OuW5qGcZQhRplVn9gf+OR4clSHfSMRF392VSNxz0406bEMpbsWNeGmRuvNx8zEaZ
    rYBww==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=arndb.de header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=arndb.de header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Arnd Bergmann <arnd@arndb.de>
To: Oleg Drokin <oleg.drokin@intel.com>,
 Andreas Dilger <andreas.dilger@intel.com>,
 James Simmons <jsimmons@infradead.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] staging: lustre: fid: avoid false-positive uninitialized
 variable warning
Date: Tue, 13 Mar 2018 14:05:16 +0100
Message-Id: <20180313130532.4015402-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K0:2HlTolkLrD6qrWoM//2uMBdGVTyl5E7EPcgynasDVSIxBHLYO/F
 6Dp9mQq7Tgig/SuJd3M4TlAmMBbMMMhAhJ2nfplrkEEimIYQiOLTUXhoR1gwnWsn/I+m5wd
 PJKd1MUVc8nSjCod+0iUKE5fD5zeGRkS+7mDEPHLSRRC7gJjahEiQHokkkP13ATHtMdBfcE
 5ghCxctF5znTP3DYmE41A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:HzjFsWE9PMs=:0HVzQaehV5S5sApoPalP3P
 0ZV0vMRhkeBJHrmwhHb+rwTiouzKgYIFiNHOcetD2xsoBZfcbKtehdwGJ7fBssyRFCXh4m1UT
 hBlCT4PZmi/Wc1s+TXmYG+yxFf+p9b/O0GRwsZzOUE4T8tD8464B5UYAvmmsDkoofErqm1BuW
 NLllO+cxaEf7uaI769KoiSucTjCNXduNV4DtToDqTDFV+Li1gaTbhbLbvTEo3OdtqqmbD3jR5
 pftw2qYxZ1LMQi0S6g9mYiw4+hDn2labthb+m6pJWUTw1628iR74N/FxV2iW+qSTs3tujjW9y
 iHB6GojWhIbkbc0CzVScDJQaaQbadEjA3isouMMClnfoSs9Lbnknr1Ala0O56CpAuG19tTG7S
 yp81RWerCYOPRYb5hAFSSQUjafGQvmR2VHPjY+oooaGyIaV1VGO2PkWdEV50IIzcgrv7YjtOG
 CIsDt8He1+vvQbgxNB79jBc8+UvtBdqgceQnBfapONU1FD4yKJSAg9E1MkD1gHyS1KS29ycQ1
 9XxrWn1n+hvjepvfqi7EwnD1pOaw4B0CVpHmL7tDdB33M6NvAwF8QYmQPwCPBeDMzL+NAy/5Q
 ccAFwbrjO5raqnB7RtXLjQ+vj1w7d2uauNNpa5XAoJrf10aRX34f5QExWDpV2WwN71sNANLiK
 ADOdbaFU0Rzx9SeZn2dakZ2NHWHtRmvjjoL7QB3N3uiIZBuV2YCGYQ840M3XVnOqQLDxzUNjd
 QORD6ZgP0oO0TVC9UKQeZ/WHMGRTeq+iusR15A==
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
 NeilBrown <neilb@suse.com>, Arnd Bergmann <arnd@arndb.de>,
 lustre-devel@lists.lustre.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

One of Neil's recent cleanups apparently has led the code to get
to a state where gcc tracks the 'seqnr' variable just enough to
see that it is sometimes initialized in seq_client_alloc_seq(),
but not enough that it can prove this initialization to be reliable
before the use of that variable:

drivers/staging/lustre/lustre/fid/fid_request.c: In function 'seq_client_alloc_fid':
drivers/staging/lustre/lustre/fid/fid_request.c:245:22: error: 'seqnr' may be used uninitialized in this function [-Werror=maybe-uninitialized]

The code seems to be otherwise correct, and I could not come
up with a good way to simplify it further, so this adds a fake
initialization to shut up that warning.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: NeilBrown <neilb@suse.com>
---
 drivers/staging/lustre/lustre/fid/fid_request.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/lustre/lustre/fid/fid_request.c b/drivers/staging/lustre/lustre/fid/fid_request.c
index fa23423eb8b3..030680f37c79 100644
--- a/drivers/staging/lustre/lustre/fid/fid_request.c
+++ b/drivers/staging/lustre/lustre/fid/fid_request.c
@@ -174,6 +174,7 @@ static int seq_client_alloc_seq(const struct lu_env *env,
 		if (rc) {
 			CERROR("%s: Can't allocate new meta-sequence, rc %d\n",
 			       seq->lcs_name, rc);
+			*seqnr = U64_MAX;
 			return rc;
 		}
 		CDEBUG(D_INFO, "%s: New range - " DRANGE "\n",
-- 
2.9.0

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
