Return-Path: <neilb@suse.com>
X-Google-Smtp-Source: AIpwx4+BY1vtL6Be/HPiQjVYyqAkGp70TpXWwaumk9wsXy+pQ9+Br2V/9WWV85yxGueFENXni93z
ARC-Seal: i=1; a=rsa-sha256; t=1522297636; cv=none;
        d=google.com; s=arc-20160816;
        b=TaCBId+sJmpJK0DxZmTTd6ME0p0W7H25KFdyjNvql94qyTPiPn4QY77lW8w7w+F/mb
         kr3au6Z/JuJpswuZmFOS0+jGe4lvn3pbToVR2N3/5lW/vLpYv+PVeWGjnWD9u38SSXQL
         H0NkOctQikRcqT4qw2oHN9Dg7WefmLHtTs4PUE3h74gd2W5uRJEk+ROmDl464b3vR2vs
         mrdjUcHLorwF/o4QxKtEi+fezTShYkTbgmcb7f9Z0ZBfUBDQYnaG1Jj4bniYwWp3XArn
         +hIP94w/4kLU3m4Smq1oZyAyT5TGHCCMpvzljE/j2PDli1xbch0ntoF/hB//ylSOVRqx
         /i6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:cc:subject:date:to:from
         :arc-authentication-results;
        bh=/ishgykC6QPPiMXD2mAlNvwRI7SM3Sd7lox9xUUcRV0=;
        b=tZ6cyYMNnMhKtKSTWXtc4QslvnbQsq97YpRWBzXB9Dm6mUNLOk3STgp7VctTYsZ0S0
         DElBnNsKCtNxPCjV6KoelIWOoruMwctKGxuPUmfnY9WA78UAL2XvsgouBqleMro1MtsB
         zXbPnckqZZ33R5zTyjmm6GreSIPwfooYdVqbhaQWsSQHoqYEvqfBN1i+k4TefCE5MeAA
         TsvQk4oKdjpEgZ5aeZBKx4W5nno5OSFY375uGf+C/uRG3wkwUD/Kr0+SQtvMfIcOvtU2
         NqqsKYYvkLIU/qZENlDGNMcVdBJnhohb9U1/6puJcIPIMQ4mpOQtvTNplncNjUbF+Jbt
         ma+w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
From: NeilBrown <neilb@suse.com>
To: Oleg Drokin <oleg.drokin@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 James Simmons <jsimmons@infradead.org>,
 Andreas Dilger <andreas.dilger@intel.com>
Date: Thu, 29 Mar 2018 15:26:48 +1100
Subject: [PATCH 01/17] staging: lustre: remove invariant in
 cl_io_read_ahead()
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Lustre Development List <lustre-devel@lists.lustre.org>
Message-ID: <152229760825.27689.17083243052405696738.stgit@noble>
In-Reply-To: <152229732768.27689.4800156943561963977.stgit@noble>
References: <152229732768.27689.4800156943561963977.stgit@noble>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596244766664542197?=
X-GMAIL-MSGID: =?utf-8?q?1596244766664542197?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This invariant can fail as ci_type is somtimes CIS_INIT.

According to Jinshan Xiong, or of the most recent significant
change to this code, "We should get rid of it."

So do that.

Fixes: 1e1db2a97be5 ("staging: lustre: clio: Revise read ahead implementation")
Cc: Jinshan Xiong <jinshan.xiong@intel.com>
Signed-off-by: NeilBrown <neilb@suse.com>
Reviewed-by: James Simmons <jsimmons@infradead.org>
---
 drivers/staging/lustre/lustre/obdclass/cl_io.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/lustre/lustre/obdclass/cl_io.c b/drivers/staging/lustre/lustre/obdclass/cl_io.c
index ab84e011b560..fcdae6029258 100644
--- a/drivers/staging/lustre/lustre/obdclass/cl_io.c
+++ b/drivers/staging/lustre/lustre/obdclass/cl_io.c
@@ -599,7 +599,6 @@ int cl_io_read_ahead(const struct lu_env *env, struct cl_io *io,
 	int		       result = 0;
 
 	LINVRNT(io->ci_type == CIT_READ || io->ci_type == CIT_FAULT);
-	LINVRNT(io->ci_state == CIS_IO_GOING || io->ci_state == CIS_LOCKED);
 	LINVRNT(cl_io_invariant(io));
 
 	cl_io_for_each(scan, io) {
