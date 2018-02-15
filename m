Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225hvksgpv5x/5wF4ZaI7/tQZ/1uCYmF46gAFWJTlAaAb+Fc0TTsU2kZh6vL26L/+un2dZw2
ARC-Seal: i=1; a=rsa-sha256; t=1518709396; cv=none;
        d=google.com; s=arc-20160816;
        b=nESI5pvFDIasiTRsdylkS13NjWP6YaG8qaxkPuWN6Ydzr1Pw3UnE4VtmKMRbXIL07k
         FJEFEsfFV6bxQVlPApicW9g/aBEgFma57mCQV05cvFRfFIMFsxPXB1lhbfv/Q+SyX5Jd
         F5R0jdAL5WbQByiTsxR+iSZxUHqmKry5JxmcgeHFcMPF/vHwLv8e0kU352danqvelXA/
         QT/qs8jjV+ktHTBFsbylFblBdsT6x8IyNGE4iWuyTMOUPob6uX2kWJI7yzLsu6tFIsGo
         ++th7mTIGNNVSjEePVLqu4gdSy/Tr3DITnYTy1duf8/BXz6DMzQOnAACcqGJ4n5SYvRL
         YmwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=nhYThPe7N9FAZqZ9YSuPminrMQt6kWmLSt4zxpY0cow=;
        b=AhdDbKYGeB1E5iednvDa90CNXZrA5R/LcA+sxhToExy+AKj7DoBu6PwsPRPEp2Lr2c
         CMQ9wMRpvDSA/WYQvjZIaq5DTcizD5c8LQrWdcBra4qpkGmxlsGZIZHOntNmH/xqn3th
         Ghdq3Kw1F7nhtJh1cD5lnfJYDXbLG7KB7Pa/8RGDw/f6CQCuxy1F+8uecWmYrR62cljR
         WKMOxabIU17VYjrTExWjb5KRKkcRetgRQlmox0TG0ifmYIhpn2Ga9ziSRDoJtZ+/3hMC
         1WERMFB20a84IH5VmqNHZz9UHge3cfL/LQelr9BGwIALR+l4nPhh8HIy0jsMf+5NLVR/
         TEKg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Trond Myklebust <trond.myklebust@primarydata.com>,
	Checuk Lever <chuck.lever@oracle.com>,
	"J. Bruce Fields" <bfields@redhat.com>
Subject: [PATCH 4.15 103/202] nfsd: Detect unhashed stids in nfsd4_verify_open_stid()
Date: Thu, 15 Feb 2018 16:16:43 +0100
Message-Id: <20180215151718.671374934@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151712.768794354@linuxfoundation.org>
References: <20180215151712.768794354@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592482223914578633?=
X-GMAIL-MSGID: =?utf-8?q?1592482223914578633?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Trond Myklebust <trond.myklebust@primarydata.com>

commit 4f1764172a0aa7395d12b96cae640ca1438c5085 upstream.

The state of the stid is guaranteed by 2 locks:
- The nfs4_client 'cl_lock' spinlock
- The nfs4_ol_stateid 'st_mutex' mutex

so it is quite possible for the stid to be unhashed after lookup,
but before calling nfsd4_lock_ol_stateid(). So we do need to check
for a zero value for 'sc_type' in nfsd4_verify_open_stid().

Signed-off-by: Trond Myklebust <trond.myklebust@primarydata.com>
Tested-by: Checuk Lever <chuck.lever@oracle.com>
Fixes: 659aefb68eca "nfsd: Ensure we don't recognise lock stateids..."
Signed-off-by: J. Bruce Fields <bfields@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/nfsd/nfs4state.c |    1 +
 1 file changed, 1 insertion(+)

--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -3590,6 +3590,7 @@ nfsd4_verify_open_stid(struct nfs4_stid
 	switch (s->sc_type) {
 	default:
 		break;
+	case 0:
 	case NFS4_CLOSED_STID:
 	case NFS4_CLOSED_DELEG_STID:
 		ret = nfserr_bad_stateid;
