Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49acY5A80Thhq+SMzeLz06ed6SzF/jXIsfaZkGQUvddptbKkgNUU+sjKuwmKWXmre9Iu4RR
ARC-Seal: i=1; a=rsa-sha256; t=1524406599; cv=none;
        d=google.com; s=arc-20160816;
        b=cZkcrGMmmayH+jkCPIOlIxU+IFD/Qf0Dve9Rk1gDDq3OVWUIhNzQrUxs/aKNwsjGBb
         NwCrnx1rmc/Y6WZyGjkOzXmpkrmMe8e/S2Sw8L3Y2Kk9gj6bF9KLaZUjwzue8NIoNgTq
         50iHALULu3pQLvdOEO2q7iPgo3cMlJ4hnLlZOpiiJskRMj23QTo0c9w/4Th/gTvRsfSv
         pwUoAyDqvFqXq74gAQvtKljDkKD9UpbWCn7KTXpqgo777DGTSzpzEz8y8rJKJeEqyJ+G
         OOChgj1n+QGPUFCnex78BRpaeLBkq3lZS0830yhY1XM4RCvIsLBXgVu+IpT7cpdQfYNq
         RcFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=g3NwA/PDuMlgYdYh09fQMLWSv37NeLUi5kuCUoje2xA=;
        b=fDw+hQa+jlKNpopZ+/C0p1H9WHglD3QeoTYadXHlHEWufU5crzM+qKwq9nWTXwesfb
         ycuLGkTHUDnQTK+jz8yK8ERessc1yiV+U67bqWCDKgU0YtOaA4xuFecnb2qqYEN8sh18
         xs2EYBUMGI32oSIE+OREcJTR9Q2TI+tbn9xQCiz0Z+Glw4D6uVir3G6U87e+fa+8eq1y
         wv5ANGb2iSMTQtmjtxpzI1merZT+TrKQvYlv3OUT90YCoSczTSVWbCBTEBRsMSeOjs/W
         uW45H5xNIcAEiFR0eDrXVNmzv8VYBfDO1UuybjTYoeXcAwycqXCf5cW6utCOfoJ+lGUU
         k6Ag==
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
Subject: [PATCH 4.4 05/97] perf intel-pt: Fix error recovery from missing TIP packet
Date: Sun, 22 Apr 2018 15:52:43 +0200
Message-Id: <20180422135304.929680811@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135304.577223025@linuxfoundation.org>
References: <20180422135304.577223025@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598456174133336852?=
X-GMAIL-MSGID: =?utf-8?q?1598456174133336852?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1492,6 +1492,7 @@ static int intel_pt_walk_fup_tip(struct
 		case INTEL_PT_PSBEND:
 			intel_pt_log("ERROR: Missing TIP after FUP\n");
 			decoder->pkt_state = INTEL_PT_STATE_ERR3;
+			decoder->pkt_step = 0;
 			return -ENOENT;
 
 		case INTEL_PT_OVF:
