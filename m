Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49ixUzwbdKrF7neAOt+DwavTgqk5QOWexuDasCr/5nMkNQBskbkXut8Q2mmyYwlrfGf8J9M
ARC-Seal: i=1; a=rsa-sha256; t=1523473286; cv=none;
        d=google.com; s=arc-20160816;
        b=akOeInYdXzZZMbegtZK6mgTkouG9ne2mkjrnKTCreDCtEEyLE/t3ekNy+hcMEYV73M
         6gttR8V693TstmMvJ2UllR9e4iR7NX1iPXB+qHoBLBD9G/vvN55DYnPZ8zXmC3F+sTM1
         8uAG8GeW4IPOgVvsfmbPfdt4y5UxPXf7eoFhhm9UWf+zQB/uhMP1xQGGuhZBIKPG5b+a
         rXAuowJCyiNjifF5w0MnqNqBJi5GsVjdYvjrsm5LBcuplJ73k6zpXdI47PyUC86xdxy0
         nmKnF55QREgeJ48jg0mZyHtKiFUwtFFJC+mYRja5wMqpcOhFa/jNUg6GeL3HpPBtenaR
         Pkdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=rTIHUsjwnt4UjgQYegva1cAkVVmg5ZQhnbZ2qg4jTF8=;
        b=zOF3XO9If4q7qB0lOZyKW67HrVsW2y7WG00Ma+Bl/5CsUEcsvOklVMKjT4bo9rPfRJ
         ueKvARwfk/LQfMVrNIR5PYbigqpDKH9IRC7sNdoLOEoUzTC0UUXPjheh3KZB6KcayGOp
         hUJSuiCXuFuCE4QY5IZxzWD6PnF6ClPWk25UpIB0DOS/xX5kFjhwvIwajoo3nuzu5Wyd
         c7td2ulVI4uKMyZ2gddpUQL73ycP6ecwXRffcKApYd4GvXmdzrqoylYUGo2q9cHh4Vqm
         1VxQTx8GOqIxx+gsjdpQzwJ7K/ddkPMd3sKip6CNlLWvM/VXLUZ43Nh8hcbFRO0GEcis
         qk2Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Felix Kuehling <felix.kuehling@amd.com>,
	Oded Gabbay <oded.gabbay@gmail.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 175/310] drm/amdkfd: NULL dereference involving create_process()
Date: Wed, 11 Apr 2018 20:35:14 +0200
Message-Id: <20180411183630.157793909@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597477524428790753?=
X-GMAIL-MSGID: =?utf-8?q?1597477524428790753?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Carpenter <dan.carpenter@oracle.com>


[ Upstream commit b312b2b25b6ac9e2eb03f4ca651b33108752de3a ]

We accidentally return ERR_PTR(0) which is NULL.  The caller is not
expecting that and it leads to an Oops.

Fixes: dd59239a9862 ("amdkfd: init aperture once per process")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdkfd/kfd_process.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -317,7 +317,8 @@ static struct kfd_process *create_proces
 
 	/* init process apertures*/
 	process->is_32bit_user_mode = in_compat_syscall();
-	if (kfd_init_apertures(process) != 0)
+	err = kfd_init_apertures(process);
+	if (err != 0)
 		goto err_init_apretures;
 
 	return process;
