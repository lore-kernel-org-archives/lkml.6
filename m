Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+reLvGj8rlgPo8oa492A1MjwvXnKi8DJHJetbL2bKEA81Mks1ixS3zsZN5MnRb2LCiefL9
ARC-Seal: i=1; a=rsa-sha256; t=1523399430; cv=none;
        d=google.com; s=arc-20160816;
        b=SrnKLXLxN3m5hCSLWDXdzauKBxO/cGfHLAiygGRRcecIAePDjCIo1BHu54nnQDU5zD
         rFJN8pRlUAJKxx7HVmf7opdzWg9kdZAUJ6rw2OG6gOJzZ7Jv5xhQ/H7AeCPY+qLCji6o
         EGngF8QDJwcDjyqTdxSdjQVYeSwR1C/gDL94Ci0i9ThF6K0vYqwAIE5COLYhn3C16vuq
         aBe+b4FT27UyDjvdHBH3c7tFMorcJLg1ueyrmLhnkgrRjn4LbpVvnmSIdsHoDi6mNJUP
         JS+hw7rihX4gpc09Qp0PM+w3GkOezsMYS7lbxcx0+PMlPo1YhHFlgBaX+bEt0vD7q6pR
         2EUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=XYCVb/7VIQkfyiroRnY6298hdiXDoItzcZV5U4Mmqi0=;
        b=xZ5hMn7UTEGXiRQXXGIF5Sdv2wCzzTrp6fjFM1CrLnZpQ/2mdQI6hoiGORjwsixN0Y
         2GSRBUK1w4wpdpM82e/lx0FtXDMTF42ytLh+108ydqSo9bYRty3Ywsxb1K4A1tGdauFn
         OiTygK5BCJBViwnzh+xFx/QPGWPVbTYu774A1Nk2MfecgiET/g4PtW8TnAZL9RlcpqCo
         krURwwGkmkMcIgGn/lygOnOKPQEOVIkGk82QKmBqwxTnSS2+nGb28qZsFMJcwY4j45mi
         2raYGA8Jb355hcsyiuNYmi2IYxRWK3yub2x1NE2fNas5E3urJNtVDmUnHzpj1qin0x24
         SiWw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jiri Olsa <jolsa@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	David Ahern <dsahern@gmail.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.15 104/168] perf tools: Fix copyfile_offset update of output offset
Date: Wed, 11 Apr 2018 00:24:06 +0200
Message-Id: <20180410212804.672473857@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212800.144079021@linuxfoundation.org>
References: <20180410212800.144079021@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597400080420179625?=
X-GMAIL-MSGID: =?utf-8?q?1597400080420179625?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jiri Olsa <jolsa@kernel.org>


[ Upstream commit fa1195ccc0af2d121abe0fe266a1caee8c265eea ]

We need to increase output offset in each iteration, not decrease it as
we currently do.

I guess we were lucky to finish in most cases in first iteration, so the
bug never showed. However it shows a lot when working with big (~4GB)
size data.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Fixes: 9c9f5a2f1944 ("perf tools: Introduce copyfile_offset() function")
Link: http://lkml.kernel.org/r/20180109133923.25406-1-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/perf/util/util.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/tools/perf/util/util.c
+++ b/tools/perf/util/util.c
@@ -210,7 +210,7 @@ static int copyfile_offset(int ifd, loff
 
 		size -= ret;
 		off_in += ret;
-		off_out -= ret;
+		off_out += ret;
 	}
 	munmap(ptr, off_in + size);
 
