Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELt/NikhcJYBp/Kpo45Q976JurNrFtGdZc0XEX5B07OzAjJId3mi27Vu/B9Oe7z9P7XeFlxk
ARC-Seal: i=1; a=rsa-sha256; t=1521214363; cv=none;
        d=google.com; s=arc-20160816;
        b=nhR6z1xW4pRFhQZyPPfvpIPzVxcHjpfK03NesjXlINEIlY7zRu1bVLkNQ2N0auYgVe
         13CMKbDKM95g6ZfJWmFNk0zf0ckwmPMm0D0KfmqfTEUHlGrFf7yVpw83WMXhSOhTzKVp
         Cta1gzKUNRpFxhC/kgGIfwkacSjyewBoUzITzh5NowMl1p75CGh/qA0LI2MXfJ82ATnQ
         qZD34Wzc8/Q2yLAKXktswU6RGYM5hPymIYAMPaEORqnHCdFATX3l49jX66DVp5L16KRV
         k+pXdCKeRuXa6dy81eFMzrciAzQ/3l/8/sECR160cMv6TQFFw53ChzbRpiLg+NRj2JeL
         3SAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=zYfcbHMPYVeny4mIBJbJ33JK7Mvj35Ac81Gyhyur1RI=;
        b=WUZd5e7fM+ZJC36Uc+f+LHKNUV/iSRkebYXVeru3AeVHkLZ4ffgnPTk42vSYzDb9HK
         6JbrThrRG2GIMgUGEEhvlhjLRZCuWQlEf7ZCxOAPdxB+v80TojMGYqzKWmmb/X/s/r8y
         T8x+U53SbBddVRL435DQQSo+wfJsLUmjwjCcw53s4AsPPyHnzV2FojHIz+xfGuUvVeki
         bduITNmkBlVfbjyf3G/YaFgxc+gxxsS+mXrKL4bBdOCbjuGXUZFuhO6ggSGU0Kr5NiZ/
         3z43vz6U9R56bZLui5e5mk2TZ8v52aUVL8UXpkiR1asJ0faeerk20Kj7yye6SVJP8V8D
         acVA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Trond Myklebust <trond.myklebust@primarydata.com>
Subject: [PATCH 4.9 67/86] NFS: Fix an incorrect type in struct nfs_direct_req
Date: Fri, 16 Mar 2018 16:23:30 +0100
Message-Id: <20180316152321.893041583@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152317.167709497@linuxfoundation.org>
References: <20180316152317.167709497@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595108686704578677?=
X-GMAIL-MSGID: =?utf-8?q?1595108871964101595?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
 
