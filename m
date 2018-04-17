Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/keSixQTwz0jYAfM98zrjg06GxXwseljMhnFZddMQ8CGmCTrv7UedBfhyAAf8yWQbrNtHx
ARC-Seal: i=1; a=rsa-sha256; t=1523980972; cv=none;
        d=google.com; s=arc-20160816;
        b=vSyR2o1stpPvHx/fKv5XvMeSElOcn9jflKNPLIDaVpdNKcaluKAnKusMvNZKCWxMlP
         oPiu2/Ix3i6h7YzHRIKgAEVbfskJHNUzPp0JO6KZGrXQ6eOnKtQvRPtzyV/pvevBq7GI
         N4BCVe0sZSFzGkvOYSdyYD+r8T9tabIlacGeSd9yL2yIRkKyGSOYS88suaPXMu9ma11E
         xUid1UUlRV1lWiz05ZXstlvOZ/Cof5G6lPLoizeMYeT8fAfaxsxe1mFCDrrzV0JCZLFl
         OxtzFvvGc8AbeZT2Kqy0WqWLpDlZvADvLSKpvArOVEgZa+W3dEoUpa3RMkNCeuSyh0cY
         u5TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=gqezzMYgCl7fodxb8vYQDlKNTsUfKviqyZRc1w4rcCg=;
        b=yDHiVUTPqGhq+E6sOZMkySDPjg9L17yF3ZAgGYfck7EARUbiDxMlT9di6kX6e2UHLx
         vekpUJo757g6uMPLHieExUcnIgcC4reci6HPAG5G45zsvz3E3ExcS1TqnnSBxcA1ncwF
         j3qJNRvsn8jh9PREm8IYPKVsWVV6gBmnfwjF3dWrbbXCkpTsxY7kMkzC9re0mUl/2U0f
         SLVup5nsm5qmICi6AUX70qaen6JECrggys+KtO9ka2JC3XRAGZYrcJ0PHxyHeLhqE0DE
         3cSBrNWtejgMhRNgBVjDMeP8j4EX5DAKgyb5yCl9QYX8laliopBESYP5zAFW5y+l44Oo
         1z7A==
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
Subject: [PATCH 4.16 24/68] perf intel-pt: Fix error recovery from missing TIP packet
Date: Tue, 17 Apr 2018 17:57:37 +0200
Message-Id: <20180417155750.329344267@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155749.341779147@linuxfoundation.org>
References: <20180417155749.341779147@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598009872047467983?=
X-GMAIL-MSGID: =?utf-8?q?1598009872047467983?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
