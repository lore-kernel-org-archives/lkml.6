Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrSJ98Nn+EDRwyIiqcHTB+GGkFEc8yhd6So+sEr5jP3qB4cNxA9Ypq6SSkXYVaNJlo8/hK9
ARC-Seal: i=1; a=rsa-sha256; t=1525116287; cv=none;
        d=google.com; s=arc-20160816;
        b=upkRWXPCIXDiEDKbQocI+wBYJlE4625lSJiJGDL+gCUnUnxRPHmsgcqutvypDootFK
         16W+0akk4kTVEQ+i/QcduSnX8XfCG8mrR9UbE6u7RwKjL9wUSj2LMNEUcHQoSN9c7YOu
         CaH8RzpA++sWvGMj0tNphkoGFmewdMz8jOdZRfHMexxwuds960DY4uxlLCKcj+mxSO/i
         zb+ibVWK9injGLEVmHv2A7dn0aL1eNlzjharwcFzgfJDkEMdJzL2C7ZscdZZjVUSuExa
         ov3JyolqqGSTAKVlBB6LNIOb5ppjcGNCVvE+W9c1aouXnZG/hTRjOeTeWDSdlx+GZtgH
         CGdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=LTyCJeyeOG3Qrzq7Bgsbz5o+BBXrC93p8TmUpGQ6OPU=;
        b=LMmrxRgPNKoZeGB4o6qFZiRPQdxdh4mPzQX0ZdHdkY1ifeA9DuV2b4lLIPv620+3um
         yt2VlUI6i+jhYMN2uZ0dJM+Z3YjAwkEpiKs8heZHC+e9SiC8SbLfSLQGLlWGCyZaqy1Z
         wIEJDd6aot90MyyVNFQSBLjq2yx+GBDoN9i8tKmXRcqK/UlUF0M3k7kRkRhYiJ4ccor/
         J4MBuWHqJZlpmzcF+z2uHtqVdXeTAAwuVZrDS5A9uVa6dPzG6qpy3Lvb13CWvIMa/loH
         dSfyxhf32TeglEKc12AwrLEGIWKlXBqpMNTY1p4cijBogkUkdEsiAwnsYiOBMFcaj7Qe
         +NiA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9708322DA3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Theodore Tso <tytso@mit.edu>,
	Andreas Dilger <adilger@dilger.ca>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 3.18 01/25] ext4: set h_journal if there is a failure starting a reserved handle
Date: Mon, 30 Apr 2018 12:23:08 -0700
Message-Id: <20180430183910.863189903@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430183910.801976983@linuxfoundation.org>
References: <20180430183910.801976983@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200336209029872?=
X-GMAIL-MSGID: =?utf-8?q?1599200336209029872?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Theodore Ts'o <tytso@mit.edu>

commit b2569260d55228b617bd82aba6d0db2faeeb4116 upstream.

If ext4 tries to start a reserved handle via
jbd2_journal_start_reserved(), and the journal has been aborted, this
can result in a NULL pointer dereference.  This is because the fields
h_journal and h_transaction in the handle structure share the same
memory, via a union, so jbd2_journal_start_reserved() will clear
h_journal before calling start_this_handle().  If this function fails
due to an aborted handle, h_journal will still be NULL, and the call
to jbd2_journal_free_reserved() will pass a NULL journal to
sub_reserve_credits().

This can be reproduced by running "kvm-xfstests -c dioread_nolock
generic/475".

Cc: stable@kernel.org # 3.11
Fixes: 8f7d89f36829b ("jbd2: transaction reservation support")
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Reviewed-by: Andreas Dilger <adilger@dilger.ca>
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/jbd2/transaction.c |    1 +
 1 file changed, 1 insertion(+)

--- a/fs/jbd2/transaction.c
+++ b/fs/jbd2/transaction.c
@@ -515,6 +515,7 @@ int jbd2_journal_start_reserved(handle_t
 	 */
 	ret = start_this_handle(journal, handle, GFP_NOFS);
 	if (ret < 0) {
+		handle->h_journal = journal;
 		jbd2_journal_free_reserved(handle);
 		return ret;
 	}
