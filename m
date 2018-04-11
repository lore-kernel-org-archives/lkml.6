Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49WGG+a3i8/IOsa1iSjorDUsVcHVY4GgX8c/OY/UKRNYNNy6tc8Y6CNmJT9eTALjMIhCx3c
ARC-Seal: i=1; a=rsa-sha256; t=1523473256; cv=none;
        d=google.com; s=arc-20160816;
        b=WvkSNKBNii6h6ZVVb+p0i5D9dklsta7sJpGjIXb2O0JfvFUn5PJpTTrc/T40Iil4AX
         5hRNEFIsuXM00J/mXNIdoYQvx/VYfCKZGlfYlvIjIDE+FD60fvsC1S+vkvhEl598nePD
         TOAosT5W/Voe1ZkbBHqQBKHUvff1klqqNjYcNhM8cPJzYL6QASB41lnE+HdEttwCnLRD
         Op7Qsh1xvpDPa6aU63c1HQgsGTHazgD5Rqbp7vIA9a33XDE6zas98lUQwE3CSOxL+2R4
         /v5pyvYV/hmflLXrDil1LOWL9dOVsXhDzjAZCLDC6cD1eoksNmRoCD+LgOHjPa1MH5W6
         ywVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=RcVG30jAscDuYHHPMD6ege9xAlu4NojbvCkwwMfvoFE=;
        b=TzpDPe2pMZ9fL215ldHCCX75RwlFD3hxG3sQIWavSCQGL0isDdE/rl7wdFgj5ey+lO
         I2clb7/Rmb6IVY2NwhtofyQydQsUsxRQRmMeQNiYGunwzmYR9fm1Y48w7D0qc4oGn1yK
         +hejYFPBR7NddYEyCOLIn6RZBYX2pZ3M791Aa+RotEJa6M00lm9zpvQUGlyqlMJNiu7j
         VwCQeC/RwooRtXSHUZXVzz3642FY1PRZmUvek1XXC5guo6weydtqiaXnYM4HbQZ3DBBC
         4tkg1sqICsqVuv8fkloFQU9pPODrh7Un3/fQbZ12fvnLTRDabiu04ifFHh1snTkHMy9T
         1Ehg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Jeremy Kerr <jk@ozlabs.org>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 174/310] powerpc/spufs: Fix coredump of SPU contexts
Date: Wed, 11 Apr 2018 20:35:13 +0200
Message-Id: <20180411183630.114903916@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476197686125018?=
X-GMAIL-MSGID: =?utf-8?q?1597477493069193824?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Ellerman <mpe@ellerman.id.au>


[ Upstream commit 99acc9bede06bbb2662aafff51f5b9e529fa845e ]

If a process dumps core while it has SPU contexts active then we have
code to also dump information about the SPU contexts.

Unfortunately it's been broken for 3 1/2 years, and we didn't notice. In
commit 7b1f4020d0d1 ("spufs: get rid of dump_emit() wrappers") the nread
variable was removed and rc used instead. That means when the loop exits
successfully, rc has the number of bytes read, but it's then used as the
return value for the function, which should return 0 on success.

So fix it by setting rc = 0 before returning in the success case.

Fixes: 7b1f4020d0d1 ("spufs: get rid of dump_emit() wrappers")
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Acked-by: Jeremy Kerr <jk@ozlabs.org>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/platforms/cell/spufs/coredump.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/arch/powerpc/platforms/cell/spufs/coredump.c
+++ b/arch/powerpc/platforms/cell/spufs/coredump.c
@@ -175,6 +175,8 @@ static int spufs_arch_write_note(struct
 	skip = roundup(cprm->pos - total + sz, 4) - cprm->pos;
 	if (!dump_skip(cprm, skip))
 		goto Eio;
+
+	rc = 0;
 out:
 	free_page((unsigned long)buf);
 	return rc;
