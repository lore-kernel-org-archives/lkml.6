Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+WUj01DgdAFyaXNv4bIwkRog1F4GtMz6a5w7dHacd6c1zWpLWnfP+ryY8wiPCSd5KY0bMM
ARC-Seal: i=1; a=rsa-sha256; t=1523981356; cv=none;
        d=google.com; s=arc-20160816;
        b=DUdq6yP+QFRPRc3pz2zb8P2xUWf9Kg9tk/3OIgKCkLiwPdk8kySGLjuKjGYYwbktF9
         S5syjBJd0bD4sps9PE1fIRIJ2mS/fkwmV8jpJ1BZV0A4j4TowLjrJ7QWsCHrtXMYJJA8
         ZfXaeDBebmSfnIgFde9SHLSExbeHYmCXnsPpUQ3+aLrHO7Vf7IK1/Tq6f5DU+2QzJzmf
         aoS4srVJT9x2eecuCAKFlQaMIUz7UNK/5pww7/OW/FkgWYgkP/b1j350G+pHJb+UVA9V
         KFmAahErr87rehBFwFdGKCMC9ZoCYr045yxDPI6CHxGDlbFN4KG1Bmys9yTbiW5sXYhF
         iXcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=dwfUNtzUCe+YoZPckliXQAO6GF20+Hhq5D/wP8Gn8kQ=;
        b=zNr9fbh9a7FDHSXrTM1PJk13IyQgT+OwIW/5zqMOzZlNpZxEMgvV7S23OKJdmXIFFb
         2w/UBkAND4HqF0HQ97rp6ORLBGi5pyUqvWSLwh9xMwdyMMQ2bdr3u71pDSoDNd4ddbhr
         QY9LOfHRO3e06X9OYirPsjgtSVfui4EqcmstNcD70iRbfHH1hxHav3TW5gZsCtFJOjLW
         DvgvGlxm8Zqpbf3H6KF6thfUUCUaQM3zT+1rlvZAfpST1PKNcxYl+z0hHy79bph6SooN
         15vjreOJrzHy/PCjuZcla8wf0nLLoVJ0eJJ3B8blO8/3nhQqydMu/xDJv8yOmN4hBuGZ
         MsiQ==
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
Subject: [PATCH 4.9 06/66] perf intel-pt: Fix error recovery from missing TIP packet
Date: Tue, 17 Apr 2018 17:58:39 +0200
Message-Id: <20180417155646.123818842@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155645.868055442@linuxfoundation.org>
References: <20180417155645.868055442@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598009872047467983?=
X-GMAIL-MSGID: =?utf-8?q?1598010274698481127?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1522,6 +1522,7 @@ static int intel_pt_walk_fup_tip(struct
 		case INTEL_PT_PSBEND:
 			intel_pt_log("ERROR: Missing TIP after FUP\n");
 			decoder->pkt_state = INTEL_PT_STATE_ERR3;
+			decoder->pkt_step = 0;
 			return -ENOENT;
 
 		case INTEL_PT_OVF:
