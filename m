Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/aZ4ORTAmt3hp0OY9zckGActt/bBxEPrM1lyAE8jSHEd5nNNSSn12DT09p7o5K57Gr9XdG
ARC-Seal: i=1; a=rsa-sha256; t=1524406601; cv=none;
        d=google.com; s=arc-20160816;
        b=voNokVPd/bvqfygr1fOvltM5Qt+9h/pz2sVugRvsYCVeeZmfcE6XiegRiz/ffkAvvf
         DANSAPuPxXA2Jp9eGGTs1aPzS1MqycrmUZaXhS0lYxjzk5IFya+H9Xj1/OIEuRVWKjfc
         Z2B+1fy1TsJ3yOvqSPGByiK9gf8O5U6a+1QvxX+X0dZx1z3DJoXMb+idiim9UJoFQv7n
         QmNmdMd21gZAMq9GvUnyT6REPxF68gbqHwrtlAv8eNRbalKFGfK3WibNoke83snJoY67
         SYn19VKe85r3zgWdPfE5abx43POrOMgsEPqJexwmmbpfNBKduzlMNJMUmcOTC/jfQxcW
         3BtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=jTC6wFm7mfGnNR1XvlSVBAQzdRc96srVggMOVyV8d0Y=;
        b=xZMfobbBP5F5MeLgujTht1zXTAGGRu68/mktdMGjDmbvXgacVU5NEK0PzcKlxrtNRT
         en3pPgfgMSI/QJGIOtWqCd0pUFdI9YEctuipP9ixoK2Pm36Bc63nJawmkLOZ43Ht+tQL
         j+K4FZFFHheAG8ePvAp1gEhR9RJ2Kzmz2uO2OUbrnmyj6ReYuQ8k/TAd6TkL5ZgZWqXq
         jY6EFul7f7rrcGrWNPSWfYXaFGFjMuJIpZG6zkz41x/Y7ki2XER6oWbCihl19PmDrs3E
         9CHIHSt5/9tpnFYZg8mNk3DYSc/cYyUNT4QQnGM5d0qrpIv40V3+zIPqA4Zk/a1exU+y
         7i+A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Adrian Hunter <adrian.hunter@intel.com>,
	Jiri Olsa <jolsa@redhat.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 4.4 06/97] perf intel-pt: Fix timestamp following overflow
Date: Sun, 22 Apr 2018 15:52:44 +0200
Message-Id: <20180422135304.986067529@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135304.577223025@linuxfoundation.org>
References: <20180422135304.577223025@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598456176994564825?=
X-GMAIL-MSGID: =?utf-8?q?1598456176994564825?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1270,6 +1270,7 @@ static int intel_pt_overflow(struct inte
 	intel_pt_clear_tx_flags(decoder);
 	decoder->have_tma = false;
 	decoder->cbr = 0;
+	decoder->timestamp_insn_cnt = 0;
 	decoder->pkt_state = INTEL_PT_STATE_ERR_RESYNC;
 	decoder->overflow = true;
 	return -EOVERFLOW;
