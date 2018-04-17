Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+WvO17CwjrLlGrE5ycuXarHPoIiKKzrostJwTOeubThorw9glxelnSSlxW+BcFM45M30k6
ARC-Seal: i=1; a=rsa-sha256; t=1523980978; cv=none;
        d=google.com; s=arc-20160816;
        b=jL3jCCUROe5geEx7HelGtfuM5UJjEoQftu1wSVIsu96ShnCbyfFZsHgOe6dDWwvZJD
         YmSrNjzpkE1S1joH+Iops/9qP1m4o9YsMhKmPd2PGnrfZDFoeaV1PgSYZydUOsmZrqOK
         cQMuMxZdfYOnnl5FF/fIghaJx2MX3jac7YpiXy2i4IVba9CgQc8EpbK6JeHSXHGxtpW/
         eJCEZb010vWtMbEjF+Yu6ps7C4X+Yf0hWt3j2wvWFsY9m0+zPTNb8vUIBt+oHbF6GGlc
         Z9SmqLlUncgFRBBOqirBW1gKep1kMchLA0tp+NuwYUK6jb39iApB+9vZp5na+foe6qW9
         E2yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=q2ilMBrsXvmmp2pajcl73LARU1bbipV8iPFSXMgow9g=;
        b=roSgN0cBZI3BO4Xk//9LYPcFa48ht5BcB0ScPmKI358b0huT6kVXHuYLPhaNgESmJr
         zww1TeKd9dXSRf1osSoeP8rYPkUcyJxNkiGEB+1u0exwt06LarvMwPFZX+itYY6Tafk/
         7YYXp6XDerWG3MtvXTYrpcw+neGlvmTzMKMyKxMvPPxpp0UvBjSZZ2PEXj2OnKYENbmB
         SLMNkkwm/ni39STFl858VhMPNfM95mSbYAPJOlSk23zY0uo0sM1zuny+y+Z8TFn+69cI
         kaB/sJGrMu7hRmJnUc23piELRH+a8ei3ghg4B4O2r4RC49omPYCgYHXeNncAj5mLhfEz
         P4lg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 4.16 65/68] getname_kernel() needs to make sure that ->name != ->iname in long case
Date: Tue, 17 Apr 2018 17:58:18 +0200
Message-Id: <20180417155751.980482572@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155749.341779147@linuxfoundation.org>
References: <20180417155749.341779147@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598009878581722556?=
X-GMAIL-MSGID: =?utf-8?q?1598009878581722556?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Al Viro <viro@zeniv.linux.org.uk>

commit 30ce4d1903e1d8a7ccd110860a5eef3c638ed8be upstream.

missed it in "kill struct filename.separate" several years ago.

Cc: stable@vger.kernel.org
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/namei.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/fs/namei.c
+++ b/fs/namei.c
@@ -222,9 +222,10 @@ getname_kernel(const char * filename)
 	if (len <= EMBEDDED_NAME_MAX) {
 		result->name = (char *)result->iname;
 	} else if (len <= PATH_MAX) {
+		const size_t size = offsetof(struct filename, iname[1]);
 		struct filename *tmp;
 
-		tmp = kmalloc(sizeof(*tmp), GFP_KERNEL);
+		tmp = kmalloc(size, GFP_KERNEL);
 		if (unlikely(!tmp)) {
 			__putname(result);
 			return ERR_PTR(-ENOMEM);
