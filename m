Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/eCEH7LWWKCFsVSMzQngdJhksUbEa3zy4uZ+EJV0qaX6SBhcqPCgyfCAfVXynbtk+WukeS
ARC-Seal: i=1; a=rsa-sha256; t=1523981166; cv=none;
        d=google.com; s=arc-20160816;
        b=M9RM+wJKPGYySjrowjeZVkGx0YHOd2Hc96OKq3uR0qZT7y8gL/2HBIPkPSp04sxpjg
         ExdWUe6B7LoMpzw6N4J2aSXZUGlcKCMwNytHhl1pLS1Q0TTlTR3hEGL+oeyD9WY9+JTn
         pw0sPpdJq3KZpch/ZhHQ1fxiCrXai64cQ0wfsnKc8VgfiDxx+v7DH3TbZhrL+JW+P9GS
         DsNmTozEWhHUFbc5WRxXpbnC8pk+0yB1Mf50o9v+UAoCmZohXbiTvSHyDXriO1qGtyRl
         xzwb4iM23r91XxdcYi2/cg8cqUCqQbgOM17YM5XNfwWKudTCMRYNBuFX67i4GPew+Ivp
         8/Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=EMUhoDQ4XDf8lmWkM+B3NBCVN309LJnyKciOg7qFH0Y=;
        b=eJxZFI0vtJ5lwPmINx8tTOpsJdX5Im6AAwDg0c/nKKR+Km+PbOysIQq9T6gW8ysU7u
         LO4hERhFeKADctc9oF8jv2zh4AnakovzTXgfUcNcHhQ96lHjwx/7eY0mxve4J48I+nff
         o7gvqQ2JwwR6eR68m2Jd2fsmi2l7RRwNBEGMurEKvQ8hjrJMbX8TA1u0VcEC16rRCVQK
         D1D/z2RMi8j7vjfoNAirrcUmeQGlmB55akf0KCu1GsrkACbtMjdpYyhvUVGhPoQXMnRL
         MB/dmM6Ba1oHzjOyEf49cEw3ezRTBDY1PEph8OGfyk8SuVHxQMmP4Rku/g7O3ksj+gJb
         VZNQ==
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
Subject: [PATCH 4.14 17/49] perf intel-pt: Fix error recovery from missing TIP packet
Date: Tue, 17 Apr 2018 17:58:56 +0200
Message-Id: <20180417155715.840495031@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155715.032245882@linuxfoundation.org>
References: <20180417155715.032245882@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598009872047467983?=
X-GMAIL-MSGID: =?utf-8?q?1598010075969434249?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Adrian Hunter <adrian.hunter@intel.com>

commit 1c196a6c771c47a2faa63d38d913e03284f73a16 upstream.

When a TIP packet is expected but there is a different packet, it is an
error. However the unexpected packet might be something important like a
TSC packet, so after the error, it is necessary to continue from there,
rather than the next packet. That is achieved by setting pkt_step to
zero.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: stable@vger.kernel.org
Link: http://lkml.kernel.org/r/1520431349-30689-4-git-send-email-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/perf/util/intel-pt-decoder/intel-pt-decoder.c |    1 +
 1 file changed, 1 insertion(+)

--- a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
@@ -1616,6 +1616,7 @@ static int intel_pt_walk_fup_tip(struct
 		case INTEL_PT_PWRX:
 			intel_pt_log("ERROR: Missing TIP after FUP\n");
 			decoder->pkt_state = INTEL_PT_STATE_ERR3;
+			decoder->pkt_step = 0;
 			return -ENOENT;
 
 		case INTEL_PT_OVF:
