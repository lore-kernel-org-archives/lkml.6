Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49aION+5k5xw1x97e+FHOLzH8nhCFAoh9FnMSmBNyK3cz2EAMPAx9bJjMNP0HhrH8tUIENA
ARC-Seal: i=1; a=rsa-sha256; t=1524405691; cv=none;
        d=google.com; s=arc-20160816;
        b=st+T2Jr7BXXe3CtM279Ul+sKYPxMjR4trWlGKWcZNS2o6sZf5Ddnk1EEgUuPAj+zIU
         ZWDCgKK0+EU9BAlvAAlTbk8EkgTx9vNPPqFuTUqqV//2BrJU80AFwNhl3Jl2Dp4r7aCX
         MQ1mSmmgYB18v/dbVH24iuTOB4e0BXF6vHYOtSKeFG09QTDRIxdDMTdFuxKrxa0GE2/6
         B/wYUcWp+x4b1xYksURkKf3woYSAOLAF5DHcJZTZ8zG5XTXO7aFCsc3pYajw8yI2eE/6
         TyvQ8nR43Qa25zGx47T9Lx3FmB/1MpBiVBlSLDcUXl2LXb2MNBshxummtLbQ1tLeBvbO
         vOIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=MBU9fwTyuVzJdHbi0EYpvR7aGrTUf8AaIBhuBA3mu+g=;
        b=NA/TP3oJFQi/RyaofMMDPVXUDYI5A9JxgJwaTGgGoEOoLKuLPMy3VH+aEUNuxTUfek
         qIHLHEOvQCgZo00XDiTLuJMf7M4I7xncH4rCHRBvfWoH0L/cf4d9cvLX6y5YhnInrlGA
         eOUfEIS6TBhRjQ5BgJjFT9dR+URVAsqSJqsCPcBSNmaa7SusSgCE5PNO1hlfv8IBmGp4
         JU7ZOyxbEnlpEUI6T18KMMTvp4U7P7b+cKywLWSUZi6jV9chmt8d9Xd2uMtWxw/vBIhL
         CeuISDLgy9Kb2146mB1M1idBswu4Ocds9eMp9LFl7daOq3l+9rWa22jCpyAhhYXj1wfM
         Xyag==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	"Steven Rostedt (VMware)" <rostedt@goodmis.org>
Subject: [PATCH 4.16 124/196] vsprintf: Do not preprocess non-dereferenced pointers for bprintf (%px and %pK)
Date: Sun, 22 Apr 2018 15:52:24 +0200
Message-Id: <20180422135110.669892022@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135104.278511750@linuxfoundation.org>
References: <20180422135104.278511750@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455222246087159?=
X-GMAIL-MSGID: =?utf-8?q?1598455222246087159?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Steven Rostedt (VMware) <rostedt@goodmis.org>

commit 1e6338cfb50e244c445ad7d891b35385bd0ee757 upstream.

Commit 841a915d20c7b2 ("printf: Do not have bprintf dereference pointers")
would preprocess various pointers that are dereferenced in the bprintf()
because the recording and printing are done at two different times. Some
pointers stayed dereferenced in the ring buffer because user space could
handle them (namely "%pS" and friends). Pointers that are not dereferenced
should not be processed immediately but instead just saved directly.

Cc: stable@vger.kernel.org
Fixes: 841a915d20c7b2 ("printf: Do not have bprintf dereference pointers")
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 lib/vsprintf.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -2591,6 +2591,8 @@ int vbin_printf(u32 *bin_buf, size_t siz
 			case 's':
 			case 'F':
 			case 'f':
+			case 'x':
+			case 'K':
 				save_arg(void *);
 				break;
 			default:
@@ -2765,6 +2767,8 @@ int bstr_printf(char *buf, size_t size,
 			case 's':
 			case 'F':
 			case 'f':
+			case 'x':
+			case 'K':
 				process = true;
 				break;
 			default:
