Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/tSe3GMqfJHR0/yIT1hkHKKEdm7EIPZ5G5VEEl3vxwevJ2ueyg0c5nO3qp51uJunlkRrGo
ARC-Seal: i=1; a=rsa-sha256; t=1523980867; cv=none;
        d=google.com; s=arc-20160816;
        b=PTx55pieO/VNp0clPsxDEg5urwBCF9a6GzpXCsatJhyxevMRoLeNWIXd37iCpDC3Lh
         QHmX1P83b8ZStmRAsrOvAkqKJq36fY0YC8fhzArJ5Y8ulG0M9z5D7ahelDtxLZyz8EaW
         IfMxnos4d6YqgRvOF25Wn3tvO2Aqz0hWmfMiKq/G5Tm1lwGkfZCYt/CkaDfXzRkB1gbP
         Uy8rvHVGUWHNWXq3TgQ/r3TuxlCi3pFqdaY9gMlunBHERf7xvs6rH7gxdhoqw1oXg79m
         LdofirfO/0El3gD7D1meTMhSBKuDU79spFYpFySB+eftdYCM3pEbOcwPcXcH/3muqkgd
         KI1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=2izObECMuzei8vDZM7OtDi22GJ1c4SMR9adtaj4KQHo=;
        b=OmTBerEFNEpZdlRfY9SeLauRhId2obpAwixR/esgUJZnCeDpLiCn8L9f/IdBk6J/kN
         oHnVeaCEIQkUnNBbqlOK+gaqBnPXdLdKeWofatIFqG267frfj28uV6EWp6pK3smQ1CTw
         wDjW8SxFRL0x2tznpHJCHCA+Zoxt//1cUnxW3kWeDPb35jnAMTBYqi7tYCK4oipA20x3
         E5b3rm6bSn/klB0KQQ5PM6FAlM/owBOxi31CJHh8fVUIlCXh7Hd4xBEZ++xyh+khyOV+
         S6yMpdjV4EakWOjfa6zvymvWkXWu4ZvjU2uL0tW0En0LYQBmnlQKAxEw/KxhV0Xf9oof
         3a6A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Adrian Hunter <adrian.hunter@intel.com>,
	Jiri Olsa <jolsa@redhat.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 4.16 25/68] perf intel-pt: Fix timestamp following overflow
Date: Tue, 17 Apr 2018 17:57:38 +0200
Message-Id: <20180417155750.365693281@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155749.341779147@linuxfoundation.org>
References: <20180417155749.341779147@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598009762717595342?=
X-GMAIL-MSGID: =?utf-8?q?1598009762717595342?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Adrian Hunter <adrian.hunter@intel.com>

commit 91d29b288aed3406caf7c454bf2b898c96cfd177 upstream.

timestamp_insn_cnt is used to estimate the timestamp based on the number of
instructions since the last known timestamp.

If the estimate is not accurate enough decoding might not be correctly
synchronized with side-band events causing more trace errors.

However there are always timestamps following an overflow, so the
estimate is not needed and can indeed result in more errors.

Suppress the estimate by setting timestamp_insn_cnt to zero.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: stable@vger.kernel.org
Link: http://lkml.kernel.org/r/1520431349-30689-5-git-send-email-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/perf/util/intel-pt-decoder/intel-pt-decoder.c |    1 +
 1 file changed, 1 insertion(+)

--- a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
@@ -1378,6 +1378,7 @@ static int intel_pt_overflow(struct inte
 	intel_pt_clear_tx_flags(decoder);
 	decoder->have_tma = false;
 	decoder->cbr = 0;
+	decoder->timestamp_insn_cnt = 0;
 	decoder->pkt_state = INTEL_PT_STATE_ERR_RESYNC;
 	decoder->overflow = true;
 	return -EOVERFLOW;
