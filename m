Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvXyD4RVYGbTG7YS3NYgiTk45UsxOvH1rGEvkYshSz3882bOj00A0JoHVkw+UY5sBUJKmzG
ARC-Seal: i=1; a=rsa-sha256; t=1520955416; cv=none;
        d=google.com; s=arc-20160816;
        b=wRHrfaoeE/n7t63i63T834yo/wESESHVcSJF+HQ32mWsIs6/hwD1uqIZC3rNj58oxu
         TgNrtk+iY1dsGpKkBQMCnrhDUWcEUxPOVHwBCRFbOMjv55D9BjK2fH/S2okAmsJ22Ey7
         TavVDLZs+uAFdsh3nStiJjpmDfWgsw70vcblm//T7D+Dlo+dZVA/B9/eIaMPsaH2Gx5Y
         wla6E0FleQbHYd5hpw7hQnNVdQ5EO5XsqhAUzuYBRocawGZyqep8y9aZ1d5bp2Q6/kzo
         r5fByhKbqDtrkuGC3ksfRAWJD65U6VS1TwKd2DLXwCJJCQ1zYLGcSokI3b4osQR3TVfP
         bYIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=v6Gp4k19qwebfVqjXf0zSeDYGPyifnckjDj06Yn2X4U=;
        b=bloyj6ufEM6nK9nKypc+hN5TSt9TY9uRlutOHDGzEb3QutNr50M3lw+bY2DDytdAbh
         5GbUEbP1nTuYxKtdwJiwmdMrqphOGNDH4yKqnUCCh3gMdT8Okl0ukjjq5w+eDUuDabiA
         WmyAH9HBOoDiMC9yhRRqnfWhBx5ayDvvJnu7eSwsX7YXzowqPZBKqGV2LuYK0aRsWYiM
         YC3GaDNuyS1zRc3TSii6/R4OzPg/zRDoPImwrbypKwf7q6d+6MSwA8ykwQNm0bRvXHoc
         yym0H0YKt7DgGNER3c5FwfKLGdOCYHZmEYmHtxpNhXBamf1Y0fkgFK34q1Bi9FfrXPiW
         jBoQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Trond Myklebust <trond.myklebust@primarydata.com>
Subject: [PATCH 4.14 043/140] NFS: Fix an incorrect type in struct nfs_direct_req
Date: Tue, 13 Mar 2018 16:24:06 +0100
Message-Id: <20180313152501.006471826@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152458.201155692@linuxfoundation.org>
References: <20180313152458.201155692@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594837183712933568?=
X-GMAIL-MSGID: =?utf-8?q?1594837347307091194?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Trond Myklebust <trond.myklebust@primarydata.com>

commit d9ee65539d3eabd9ade46cca1780e3309ad0f907 upstream.

The start offset needs to be of type loff_t.

Fixed: 5fadeb47dcc5c ("nfs: count DIO good bytes correctly with mirroring")
Cc: stable@vger.kernel.org # v4.0+
Signed-off-by: Trond Myklebust <trond.myklebust@primarydata.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/nfs/direct.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/nfs/direct.c
+++ b/fs/nfs/direct.c
@@ -86,10 +86,10 @@ struct nfs_direct_req {
 	struct nfs_direct_mirror mirrors[NFS_PAGEIO_DESCRIPTOR_MIRROR_MAX];
 	int			mirror_count;
 
+	loff_t			io_start;	/* Start offset for I/O */
 	ssize_t			count,		/* bytes actually processed */
 				max_count,	/* max expected count */
 				bytes_left,	/* bytes left to be sent */
-				io_start,	/* start of IO */
 				error;		/* any reported error */
 	struct completion	completion;	/* wait for i/o completion */
 
