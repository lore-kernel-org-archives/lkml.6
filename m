Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZoD+PNNAjqyVQU5XwC768xPp2xdbpgW+6UCCqL6fnRigLnr+HHKH3FlVSAFPD9BXOiz27Ls
ARC-Seal: i=1; a=rsa-sha256; t=1526937516; cv=none;
        d=google.com; s=arc-20160816;
        b=yz0kHW7z97whiyMBLgem71ZADrR53FDijesqSigaZxfo3w+hXcPmMqMesIgpKa79Ca
         Z2orawoef6cs6x7lRKHIPci1tB7+CShuL8Hzcl9vdfiWkhPw1MyV/+YKcSEwGy5bECJL
         XroVrCtmEwUPJNxZmTadg6CBtxoWldzodBzuc7QqPjSJz0neRCDKPf4ZnEN+YgaHx5yQ
         HVN0Au3D9iQddkHDPcVpOhKmCR+lar8b1B0FgNx/tqbMb3knqTNQxrLn6G1FHASekMpp
         3zvqS8jZIxozOPa1a9EOaAuAj3xobvRwWKRvDfEGTW0x692Ip1ZUXtKoGF4h8YrN002U
         3ZOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=IJwKlPuDZeVLslqu67NVr2pwxyugOp0w/I6XZ7DnG94=;
        b=Y7G94SRfwc8lR/ZjjtYfgBBwHarji2DDuZpvNX3C0/L89DUhQPk0EzzpqX3nC2PuOf
         NaCmatZnpiAcpGy3pnUuRRSBeWUgPWzXx432jZKaMTuLkkB+H/DGVuMxCmuEZ+g2pEHV
         ONZ7FtTK/FcqyvC1UxFPnnHRcwf8d2vECO08kRfiRlYjUZ30Ut1yMKw3twJYOKaMaqST
         2MkwGIVZ3RRWZA5SsXmzSHjDE9NRK6M9uNkpQlsKLFsOTdg8hBDMrXok3IRLpF1K6Z5w
         nu63cfoaRnettI1uZNVp7+im+84aG8/qPc4jECYmBUvwMB/UbF7+97yugXK97o63XfIQ
         QjNg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=atN9lxWI;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=atN9lxWI;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Nicholas Piggin <npiggin@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.14 22/95] powerpc/powernv: Fix NVRAM sleep in invalid context when crashing
Date: Mon, 21 May 2018 23:11:12 +0200
Message-Id: <20180521210452.655010422@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210447.219380974@linuxfoundation.org>
References: <20180521210447.219380974@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601109847879759429?=
X-GMAIL-MSGID: =?utf-8?q?1601110033499105158?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nicholas Piggin <npiggin@gmail.com>

commit c1d2a31397ec51f0370f6bd17b19b39152c263cb upstream.

Similarly to opal_event_shutdown, opal_nvram_write can be called in
the crash path with irqs disabled. Special case the delay to avoid
sleeping in invalid context.

Fixes: 3b8070335f75 ("powerpc/powernv: Fix OPAL NVRAM driver OPAL_BUSY loops")
Cc: stable@vger.kernel.org # v3.2
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/platforms/powernv/opal-nvram.c |   14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

--- a/arch/powerpc/platforms/powernv/opal-nvram.c
+++ b/arch/powerpc/platforms/powernv/opal-nvram.c
@@ -44,6 +44,10 @@ static ssize_t opal_nvram_read(char *buf
 	return count;
 }
 
+/*
+ * This can be called in the panic path with interrupts off, so use
+ * mdelay in that case.
+ */
 static ssize_t opal_nvram_write(char *buf, size_t count, loff_t *index)
 {
 	s64 rc = OPAL_BUSY;
@@ -58,10 +62,16 @@ static ssize_t opal_nvram_write(char *bu
 	while (rc == OPAL_BUSY || rc == OPAL_BUSY_EVENT) {
 		rc = opal_write_nvram(__pa(buf), count, off);
 		if (rc == OPAL_BUSY_EVENT) {
-			msleep(OPAL_BUSY_DELAY_MS);
+			if (in_interrupt() || irqs_disabled())
+				mdelay(OPAL_BUSY_DELAY_MS);
+			else
+				msleep(OPAL_BUSY_DELAY_MS);
 			opal_poll_events(NULL);
 		} else if (rc == OPAL_BUSY) {
-			msleep(OPAL_BUSY_DELAY_MS);
+			if (in_interrupt() || irqs_disabled())
+				mdelay(OPAL_BUSY_DELAY_MS);
+			else
+				msleep(OPAL_BUSY_DELAY_MS);
 		}
 	}
 
