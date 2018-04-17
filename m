Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48kXGXUzM9TpC40t3huG5qKfR81xJUcjpLp9h2Z3lZKSp2Z8DX4fSxBsrsTnqLB8+REGF7D
ARC-Seal: i=1; a=rsa-sha256; t=1523981357; cv=none;
        d=google.com; s=arc-20160816;
        b=g7KuEyBo+mv8w7M4pJk86mv0P/Seb5PMPIrEDOF07HSAKu9iy1TKzu4KntFXgH6xQT
         XEhX08p2gc8dRWCN9vWdJEGrxaW2fAwgrkVpwgwxcaVd4LuJNf6ekQ9EOmqb4PphHA/B
         Q9j3igNaFtAt2YM6Tfz5rC66zII+SJ8QEOl7TddUZKAo0/eCXbm/5XI1Uhg/RuR8WS2U
         UJo6FJh+82VFpfKCM6ga6kNNn/XraEIQFKjzUuyKm2M7rTnWe8PoJQfu5vfoZbTm1hR8
         nhBRmji3fkgYhgAQF595I+NMto8SGfH5RTIyolZ6CCUFNo8eBk4d22eIKA9vZ/cBbGVB
         Hp5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Slw8PocCCmYzdbwNLXS/fujqpGn7R3bk1cOjXJec0HE=;
        b=ZXq29aqw8iChhY7PDct0kS8UwVFb0kOKTukc1RZMk29ND89tXLeAK/AyELKC5A0Rja
         myOJS7sLXUoalypPEF7PEO3Ip1ePpvli2YQR5Hk6iylFXTeYh+/hCFkYl74P+sX2hQFG
         xs77+YthsViXFuk3Psgab6CGRdL+MQp9AXoUZS9sc3PtddMjqmdxketifYhdMjewyJez
         Y9Uzajv15YGDjf4F7HkKZbcr6T1d0o8mYPiVa0AQcLzlt1aCqOn6P04MUeZqUhShWB/Z
         zPDE0x5arG5RwGJVBvMzaCZBfq2tVbEp5yxJkidBuTtRBZ4aGkoxEFd4jpfVq/AClppW
         ygyw==
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
Subject: [PATCH 4.9 07/66] perf intel-pt: Fix timestamp following overflow
Date: Tue, 17 Apr 2018 17:58:40 +0200
Message-Id: <20180417155646.168314771@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155645.868055442@linuxfoundation.org>
References: <20180417155645.868055442@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598009762717595342?=
X-GMAIL-MSGID: =?utf-8?q?1598010276433759048?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1300,6 +1300,7 @@ static int intel_pt_overflow(struct inte
 	intel_pt_clear_tx_flags(decoder);
 	decoder->have_tma = false;
 	decoder->cbr = 0;
+	decoder->timestamp_insn_cnt = 0;
 	decoder->pkt_state = INTEL_PT_STATE_ERR_RESYNC;
 	decoder->overflow = true;
 	return -EOVERFLOW;
