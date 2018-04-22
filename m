Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+0WXJWyQ9ilj0U2ef7G15EtUZ0QynSoGIevnmPxoqSKybhs3WGkoEIZ+vg6FupEv4eU7uE
ARC-Seal: i=1; a=rsa-sha256; t=1524406088; cv=none;
        d=google.com; s=arc-20160816;
        b=TxiQKyyMgfnY9ytF6F4uu+3mg625LPMt8cNnW7GTxex+zxzz7F430P1HH+YO3zDOD8
         gxlEm7CMI7PJYWIAfI67rb0WL4o610vX/5jbGagyu7yb+ZGxd57Xur88UyAefXEcGPoO
         njh0ND+2frltEwFsd2PQDKayOo1CwpBQ4bG5B1Uem8SZIgjCAUvgdm+52fYbEkxY3V/o
         JlbNhWxLDaCGW/LxO4OJSwuT/ykIVRH/ne4Wa3mXfR1gnZDJpoONhqNRwsoacZRnPJe3
         mDj5zpE+Qui0ZDpj1mz056SQ/PCvvcQHnNMrReACJOY+KtmtJgb/zSxk/c+vyhw+KWTr
         MbZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=rAMJCtkGl+lt+0RFLcy9z3R3y0TMsUuQkEAFQ2FKNzg=;
        b=UfqJ3eHMEj71W6DKPb2SDA9OK8flriNHD2eZ6Qs1D8xnZvcGNf47jIpA62zPT6trH9
         PF1rbC56x+8mCLKFMLpNeSGk9jo9dItxna/YMTxrPE6NgjJrq2wNIPlA3sMmekBmHAeY
         UW+owcI7Sin+b56aTMZpi2drYg14CMw0q8qqf8fxA5StXVbcPPRp1/QhOmTx0Hz61vNa
         VFOeReKsLxWDFSl0EgZOiGRayOdB1E815I6b0PhtkkNnCeQRHz0FhrOX2//7wTYSPozm
         IGXxoqygefvmqnIegllIU9npW7jTZL2/qP2VLeq4yjWdsA/5jaGWEh5vyK1vd+i28fHh
         wnqQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Theodore Tso <tytso@mit.edu>
Subject: [PATCH 4.14 073/164] ext4: eliminate sleep from shutdown ioctl
Date: Sun, 22 Apr 2018 15:52:20 +0200
Message-Id: <20180422135138.446311792@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135135.400265110@linuxfoundation.org>
References: <20180422135135.400265110@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455108516709851?=
X-GMAIL-MSGID: =?utf-8?q?1598455638356530817?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Theodore Ts'o <tytso@mit.edu>

commit a6d9946bb925293fda9f5ed6d33d8580b001f006 upstream.

The msleep() when processing EXT4_GOING_FLAGS_NOLOGFLUSH was a hack to
avoid some races (that are now fixed), but in fact it introduced its
own race.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ext4/ioctl.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -498,10 +498,8 @@ static int ext4_shutdown(struct super_bl
 		break;
 	case EXT4_GOING_FLAGS_NOLOGFLUSH:
 		set_bit(EXT4_FLAGS_SHUTDOWN, &sbi->s_ext4_flags);
-		if (sbi->s_journal && !is_journal_aborted(sbi->s_journal)) {
-			msleep(100);
+		if (sbi->s_journal && !is_journal_aborted(sbi->s_journal))
 			jbd2_journal_abort(sbi->s_journal, 0);
-		}
 		break;
 	default:
 		return -EINVAL;
