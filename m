Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtxma3xpcnJtO4GqwvS+cbyzV9vlCWmkifIP3JaMu0eVCLUYzen/stOAPWvczRwpu8uDE56
ARC-Seal: i=1; a=rsa-sha256; t=1521214392; cv=none;
        d=google.com; s=arc-20160816;
        b=ItMF3hq3ZaRqYq7tpRZPuVyRSy0wyc/3yrIBlEr2GhhsNhFlOp4KpxrZvW+8RN2h/m
         j8NVSw6o4gROxTqHbvjC15kccHXpFO7lpTX0w7xEpCgmzHGKOAS3ZDFXqA77sXuRbtFb
         im2+i7qcF+EOzlQtviTlST5N45K7Cv6WpIhKampnw/59IK1x932FlEKdobGweSlgTIqA
         rdjosZ0jLW0V18npny71NOCYkS43Ai2FZCSFkwaKk7eZ4q9u9cUPS42jZS+zhMDmEOm7
         S/dHn8wichZizxKhektXf9Pf321f03UiwjDV5uRZLeWhuMwCvXlyTPp26IHBZvqsx6QC
         yBNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Ddyo13hB3K9pjG2sD2/9NSnF6+jGK0buYnehZQ17CsU=;
        b=VgV6+HeE/tagKwxSawflUHB1eDcuW/S0+gHkHz7TVEBYPjv7Lyk9OPOaVcRx1LKllM
         a9dSwXUEWdWjSkDPG2+uHVUHyXRP9SaEJ8tQga5Xs4TXiqfnVNm9JARF+I4d1DTqifpW
         mvkiqyXDLH08YohPak36uKbVi+eDN9rbuboDmTxUr2PncgWCZMvboGdzTDHMcla/mu7A
         l/+2T+Pf30lNZtm3c9LUDWxrRElMhCDO1w1zsSgPbzBjCYzt3eIHpbN0+EtlponQlt8N
         +sy8bpKPGnp8hpqkTz1wg12i2ThXrL2+SRJXjkL8Hu8B2O2GFaGbpdnCiKiW6j6ibiR4
         GecQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Frank Mori Hess <fmh6jj@gmail.com>,
	Ian Abbott <abbotti@mev.co.uk>
Subject: [PATCH 4.9 76/86] staging: comedi: fix comedi_nsamples_left.
Date: Fri, 16 Mar 2018 16:23:39 +0100
Message-Id: <20180316152322.466885794@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152317.167709497@linuxfoundation.org>
References: <20180316152317.167709497@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595108638756515720?=
X-GMAIL-MSGID: =?utf-8?q?1595108902836533037?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Frank Mori Hess <fmh6jj@gmail.com>

commit a42ae5905140c324362fe5036ae1dbb16e4d359c upstream.

A rounding error was causing comedi_nsamples_left to
return the wrong value when nsamples was not a multiple
of the scan length.

Cc: <stable@vger.kernel.org> # v4.4+
Signed-off-by: Frank Mori Hess <fmh6jj@gmail.com>
Reviewed-by: Ian Abbott <abbotti@mev.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/staging/comedi/drivers.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/drivers/staging/comedi/drivers.c
+++ b/drivers/staging/comedi/drivers.c
@@ -484,8 +484,7 @@ unsigned int comedi_nsamples_left(struct
 	struct comedi_cmd *cmd = &async->cmd;
 
 	if (cmd->stop_src == TRIG_COUNT) {
-		unsigned int nscans = nsamples / cmd->scan_end_arg;
-		unsigned int scans_left = __comedi_nscans_left(s, nscans);
+		unsigned int scans_left = __comedi_nscans_left(s, cmd->stop_arg);
 		unsigned int scan_pos =
 		    comedi_bytes_to_samples(s, async->scan_progress);
 		unsigned long long samples_left = 0;
