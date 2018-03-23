Return-Path: <dianders@chromium.org>
ARC-Seal: i=1; a=rsa-sha256; t=1521827928; cv=none;
        d=google.com; s=arc-20160816;
        b=UWk0MB0oDELq3KLxJMCR0tuzEQnMqKRi0FOTyUkV5+TiYQ2e8juazQhdRVjNw7TuRH
         +EooxRtCrItNj89/Ygl+r18rgZiZ9y+vbrv7b8/YyWnxz9cORZI8BSh+0c70OCX/CohC
         ZrrvIix8yPtd9qRrlCo5TVfKgucGKlFRRBDd+uf3rNLkd3hY7mI/KiNvqVb+dzVyj3Ka
         XF855+AhW6fdgFQsmCpdxIXz5WxrTiLQOwKN5XqkJdcJPN+dAjOHoWAEC0BsI/mEKEO0
         JoYP53JupcPZslocKXJCIRPyQNkMuT8cigcqAOyFVgA46JReF5NLnUnqGfVRl4oJ5DCO
         wZHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=kdgwOxjF99zkZoyFvPDHDQk1+zRlS3q3NV8Pid6eDxE=;
        b=lditTojsUtljs6ijcttz7IuNR0CECS2qqYUqrBOltWXUHQGNW8Pwid+CofIK0JtCC0
         Vls6KG8qzoFPg4gpQYOOXa2Bx763H2nrCvGawkN6l16Z3UvEVGaWysPnNCA7r8J/jVIw
         zS5zb8SKl6JtiPN1KIaf34zbStKlxBCIqz/D0ab3AHF+oe2nhYO4UVi1gTWJFHEy56fg
         1pUGvUnD+8NXVN+081fZxG5u/ejDNbmNPgTrYWJ7oUkmGmo10Hihj+CG8+OzC/K9ETti
         K/9mkTouOo18PtivcUnbvS3tJuvgezUUhlrQVsOS8VAVTdr7315wQ9SsuA9rBcEyb54Y
         WrKA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=c4v7+amn;
       spf=pass (google.com: domain of dianders@chromium.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=dianders@chromium.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=c4v7+amn;
       spf=pass (google.com: domain of dianders@chromium.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=dianders@chromium.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
X-Google-Smtp-Source: AG47ELtX2BYpQGPSm9KHKg5+N3xE5jH4ajtVSgm3UFbDsxiAAGyQ47OHRmtSa5RC4+QgLtOD3nPB5g==
From: Douglas Anderson <dianders@chromium.org>
To: gregkh@linuxfoundation.org,
	jslaby@suse.com
Cc: kramasub@codeaurora.org,
	evgreen@chromium.org,
	swboyd@chromium.org,
	Douglas Anderson <dianders@chromium.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] serial: core: Make sure compiler barfs for 16-byte earlycon names
Date: Fri, 23 Mar 2018 10:58:31 -0700
Message-Id: <20180323175831.123652-1-dianders@chromium.org>
X-Mailer: git-send-email 2.17.0.rc0.231.g781580f067-goog
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595752242055143889?=
X-GMAIL-MSGID: =?utf-8?q?1595752242055143889?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

As part of bringup I ended up wanting to call an earlycon driver by a
name that was exactly 16-bytes big, specifically "qcom_geni_serial".

Unfortunately, when I tried this I found that things compiled just
fine.  They just didn't work.

Specifically the compiler felt perfectly justified in initting the
".name" field of "struct earlycon_id" with the full 16-bytes and just
skipping the '\0'.  Needless to say, that behavior didn't seem ideal,
but I guess someone must have allowed it for a reason.

One way to fix this is to shorten the name field to 15 bytes and then
add an extra byte after that nobody touches.  This should always be
initted to 0 and we're golden.

There are, of course, other ways to fix this too.  We could audit all
the users of the "name" field and make them stop at both null
termination or at 16 bytes.  We could also just make the name field
much bigger so that we're not likely to run into this.  ...but both
seem like we'll just hit the bug again.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 include/linux/serial_core.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index b32df49a3bd5..afef67cc27d3 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -348,7 +348,8 @@ struct earlycon_device {
 };
 
 struct earlycon_id {
-	char	name[16];
+	char	name[15];
+	char	name_term;	/* In case compiler didn't '\0' term name */
 	char	compatible[128];
 	int	(*setup)(struct earlycon_device *, const char *options);
 } __aligned(32);
-- 
2.17.0.rc0.231.g781580f067-goog
