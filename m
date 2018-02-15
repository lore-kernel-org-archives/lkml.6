Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224zW9yizwUMISHN6Qd58JDhKloFtEAPTZjBnusmGYfHDBorjM8TDZT/+cMQXBoJv1GiVzQI
ARC-Seal: i=1; a=rsa-sha256; t=1518708599; cv=none;
        d=google.com; s=arc-20160816;
        b=Qg0chmi6PP1g44dAPqMhgHEKsBj70scrRIY8cAGaqigLo0V6NXJmDwPUDgP6xsZToH
         pa6Kp+M08vIdvFopecEk3wQTMU+daxDeqrVGgopGBUSivrB7GmGanKpy//0CqQzeRS2k
         sTAYmSB54uT4MJ0vGaHoZ0tTLEgGoAOJIVyscsNyzwoQZgUULd0ipcpvdAF8ckOIoWU8
         7CEj22z5wDPwXBqzlceAjghXjpswrdtets9fIydYWJf9fSecX91kY6MD83e65V2/R45g
         FRWhDwMDfHyunRkc2S6CrFnSRK3SWf1ksh7xKoqepizN2AQR3wRyaV0Qr7JcQVn/42yF
         Bpwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=pl4OIndYzyqIOzX5nxiqJedXeZpYF3pAr1sAnBNefZE=;
        b=Lw53anC1mQiIlCpu8YIvPJg5UMNgzP90zZjYnYNvizqbjEmKzsTMgBiqtSOEsWSThm
         KEcOjrkhtvIIoIHx/eewuNUEd1cbUimtH2QctUv30QYrTQb4B4Mf4Yj7YUGFl/KCWpRy
         Kfg9I6ZX0E06VE98lxwqsvNTdSO0T0U/WBjtq3agFB2Y+qiLZyu/G7BlpzuetvWhXhlD
         KUOJVy3a/2pd+SQhf1Xwr3zzJpulXZla9uwlUXr5PFZIMlAfKjRrLBGMOfQTf4zwNQjB
         enRmRucE+3sthk+z97h2Mva2kb5TvSFUZg+ajzZlKwEwBi17jJYyrggARzR7Es0pldFT
         njPQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Daniel N Pettersson <danielnp@axis.com>,
	Steve French <smfrench@gmail.com>
Subject: [PATCH 4.14 004/195] cifs: Fix autonegotiate security settings mismatch
Date: Thu, 15 Feb 2018 16:14:55 +0100
Message-Id: <20180215151705.961429909@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151705.738773577@linuxfoundation.org>
References: <20180215151705.738773577@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592480805099835569?=
X-GMAIL-MSGID: =?utf-8?q?1592481388666261762?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Daniel N Pettersson <danielnp@axis.com>

commit 9aca7e454415f7878b28524e76bebe1170911a88 upstream.

Autonegotiation gives a security settings mismatch error if the SMB
server selects an SMBv3 dialect that isn't SMB3.02. The exact error is
"protocol revalidation - security settings mismatch".
This can be tested using Samba v4.2 or by setting the global Samba
setting max protocol = SMB3_00.

The check that fails in smb3_validate_negotiate is the dialect
verification of the negotiate info response. This is because it tries
to verify against the protocol_id in the global smbdefault_values. The
protocol_id in smbdefault_values is SMB3.02.
In SMB2_negotiate the protocol_id in smbdefault_values isn't updated,
it is global so it probably shouldn't be, but server->dialect is.

This patch changes the check in smb3_validate_negotiate to use
server->dialect instead of server->vals->protocol_id. The patch works
with autonegotiate and when using a specific version in the vers mount
option.

Signed-off-by: Daniel N Pettersson <danielnp@axis.com>
Signed-off-by: Steve French <smfrench@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/cifs/smb2pdu.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/fs/cifs/smb2pdu.c
+++ b/fs/cifs/smb2pdu.c
@@ -733,8 +733,7 @@ int smb3_validate_negotiate(const unsign
 	}
 
 	/* check validate negotiate info response matches what we got earlier */
-	if (pneg_rsp->Dialect !=
-			cpu_to_le16(tcon->ses->server->vals->protocol_id))
+	if (pneg_rsp->Dialect != cpu_to_le16(tcon->ses->server->dialect))
 		goto vneg_out;
 
 	if (pneg_rsp->SecurityMode != cpu_to_le16(tcon->ses->server->sec_mode))
