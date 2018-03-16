Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuIa/jmVnqKEEvw8DzTCazNW4r1+vf8eYplRZmHNYGF9VBvestWLqCWGZwLPR8Q6gdtnAK5
ARC-Seal: i=1; a=rsa-sha256; t=1521214186; cv=none;
        d=google.com; s=arc-20160816;
        b=qPauwBeWAhbRsk+RvF3Ot2hJWz7JwW8xwNYeUTtnwz+CWkcyiqvcx8VeyVyowqmODE
         xxj2MUfhjoWJcYvBhhlRmMwNODxzUMIhJPP8E+bX1ZWGgzlnDsRyrU2YFySEsTUKlGFU
         ybSQ3DO5tfOIcAlO+DpHkQc6LRBdmVVTmAWmj88sjHyxV+TcFzUkKXtX+BX0kv0CDYNr
         6MA/oR5Itk2iovqstXrHM26K9xbqPBT6NtsOkidK/B0byZoygd3RKqC39LL0kjVa29qs
         ujXeMo1Ub1knXs3OIiSMBO9hNP3lsQAOfUcsR6CYvfR1bDd4NkbK6xSx7Rvumoy2TVxe
         3GyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Cr8RtctnGSuDMI9kR+6ldufhQ5+dNMkAtQ9NImPVZhc=;
        b=zvSVmXlpsCUG65N9NWFAg51NW4dYeO+w80BaA0uxNy+iDhn2jItCDJyj3FA3eNy1fp
         0wfJWOHCv8OeVhz6T0EotfcWQoy9nPS2e3IGmdlSOeKIjd+CXKlSweQcxUqK/uAdOAtn
         NwhyxGiOUMBObiFeQHoWsQSAEf2GYgxxlsY6OLeobY9prCWvex2eY0OoRL1Wwd5YD82U
         tRf+0iyFn1eEDvXGylCkJnIALxmF0BDIN8DIDBy6owaRZmgr6OpyYCbdBArjGspG/YaP
         ZK7RvBekbzHDHJYSzTRPauMEZwMxQ32670jbKrn+xbFTpnk9kzrP7Y9m5hTxpoEFobsu
         fLhA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Trond Myklebust <trond.myklebust@primarydata.com>
Subject: [PATCH 4.4 48/63] NFS: Fix an incorrect type in struct nfs_direct_req
Date: Fri, 16 Mar 2018 16:23:20 +0100
Message-Id: <20180316152305.014966435@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152259.964532775@linuxfoundation.org>
References: <20180316152259.964532775@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595108686704578677?=
X-GMAIL-MSGID: =?utf-8?q?1595108686704578677?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -86,9 +86,9 @@ struct nfs_direct_req {
 	struct nfs_direct_mirror mirrors[NFS_PAGEIO_DESCRIPTOR_MIRROR_MAX];
 	int			mirror_count;
 
+	loff_t			io_start;	/* Start offset for I/O */
 	ssize_t			count,		/* bytes actually processed */
 				bytes_left,	/* bytes left to be sent */
-				io_start,	/* start of IO */
 				error;		/* any reported error */
 	struct completion	completion;	/* wait for i/o completion */
 
