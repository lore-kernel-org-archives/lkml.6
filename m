Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/bU9q50lEXJhUwFipOYgez5hlkgUCMMo0kD4wAwOm0EAvN/H6CE1ReZvjAN6He2y8jKhCr
ARC-Seal: i=1; a=rsa-sha256; t=1524406478; cv=none;
        d=google.com; s=arc-20160816;
        b=JXWcy7wZTR17n+eCycI1Q0SGvGr4ovCX2rM1QRdRPt/YCimY2oQOcQlJDIsNnAm7h5
         Rwp1vHBX4Z0c9OE/g9PHECvV2PkPPDbOw/mp0Sdv2mpE7L2c7XwwqfAbeQwsWZdK73fF
         kZK8ZS2Bcl6X4nYr4hBUSdlpCbkkN8sydNVrOmj2N8oHoyv2lWmb+hxdOyj9tttui5S2
         q1DmaylKq0umjvWpmIDfVtX1QslLXQ4Fy6WVWjPD9/KooSfLf9V22OMXaaEBQ1BbWCd3
         OC5+y/+Zo8dBVAt17Z2SRlv5WUCA7wMtObSf+87TzOVsRNT9RWN2f9f7sYh7nPRNF1yO
         zqIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=RsXLrIoYCQPZMCfT3e/SV1v62+BpsP6n2gfmX/eXiow=;
        b=xit3h15ZDATRzSaptsX0R4gb8FF/JAnnvPCijIJHd7oqbh4SgpRIzTx+shVEcLs4Af
         3Z/iWMz2uWaCkSXMtiAgrTu7dRAZcQf+6Ki7LaQqedXqkrdSqfexKC+5UuB2YoPYz/+g
         cITrOXZCTp9LqZO2tdvJSELAYB5pK1WLVOJkUb54NLCuFo87MoKkwqNw5I/Mn2H4k1UU
         NsTAgdQM8bQJafYn/zuR4RW+P0uOmiXV2bb5Hi4pwIy1jKaF0C6oouC6ZSpq9Muztpfb
         T47VlFbbZUALE5Yu3AeJ+d86LllvHImnGDsXMCAoEysLOUEvcQlfo4/VaKeiTb3WO0Ie
         D9jQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	stable@kernel.org,
	Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 4.9 86/95] jffs2_kill_sb(): deal with failed allocations
Date: Sun, 22 Apr 2018 15:53:55 +0200
Message-Id: <20180422135213.954335057@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135210.432103639@linuxfoundation.org>
References: <20180422135210.432103639@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455296001564501?=
X-GMAIL-MSGID: =?utf-8?q?1598456048078903710?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Al Viro <viro@zeniv.linux.org.uk>

commit c66b23c2840446a82c389e4cb1a12eb2a71fa2e4 upstream.

jffs2_fill_super() might fail to allocate jffs2_sb_info;
jffs2_kill_sb() must survive that.

Cc: stable@kernel.org
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/jffs2/super.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/jffs2/super.c
+++ b/fs/jffs2/super.c
@@ -342,7 +342,7 @@ static void jffs2_put_super (struct supe
 static void jffs2_kill_sb(struct super_block *sb)
 {
 	struct jffs2_sb_info *c = JFFS2_SB_INFO(sb);
-	if (!(sb->s_flags & MS_RDONLY))
+	if (c && !(sb->s_flags & MS_RDONLY))
 		jffs2_stop_garbage_collect_thread(c);
 	kill_mtd_super(sb);
 	kfree(c);
