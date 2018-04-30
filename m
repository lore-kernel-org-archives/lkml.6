Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpLX2iP9B4o8ONWI5bBIV9F16HHZuyGue3e60E1Bnm0apLx0h36DdQMwESRuMoJFUslnwha
ARC-Seal: i=1; a=rsa-sha256; t=1525116400; cv=none;
        d=google.com; s=arc-20160816;
        b=gPA8njSBmNBmC/WGCGuuGEzN+gbK7v6tdDjE0ot16E+M4UALODhbH0lAWxGJrH4J7T
         DIfvAAhCytRKKh0l+mL1b94rR3NK5ASttIZdfCTblRygo5i7wGuI99gio7+WvfR+AkbQ
         re10np574tu70k66U9MrMno1RblnZ5BSrd87L3exTHqTtYL3haWTl1qgpiPbXeacRN0g
         b09/4VBfnUlTjNpNovTXoknyq1lQ5epkcb3BLiHZwvq4u4I+3lN44863NLI3LFmrQ/em
         tcPbImZD3cHwrtanekfnIqKrevN/vUysS/iBM9JBgdD6TygxGpqws9U34ZPIPQ9YszAZ
         GQJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=MD7EnFlp7xJrZ3qcg/6G0tnJNhemfQilBU7YyTuX9Lc=;
        b=HYSXzoe+PPEGQx5CSg1G9hrRZwsPokOKsdIZI8JzV1SQU8302inuuZkQMZjlYlKbWu
         XIEu+Wy7YSuDfeCr/ej1dxbV9hwyYQ89QqgZXkEhcsSSV16WyFVmWRnj8kkKs62hNQeS
         lsaeymkZfTLTz9ZiZmKdpk98u4BBaecODv9RD2lZBmMafP66mnVzzUHKWwwNMJK34zNX
         BAoIYUV9VBYM9H2z4fTouoQerXoZn/eOQ2W3VT4D1ptTpS194wcUHtH5YgZfPCunM2pE
         xZ58xFRs31MgsTWPDiP4BuYvGoiNBLnqMwq+RJ6aCb9WRdRfFz03uDkd5Lfvm8hvWXPa
         0BQw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5074622DC0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Ilya Dryomov <idryomov@gmail.com>,
	Jason Dillaman <dillaman@redhat.com>
Subject: [PATCH 4.9 49/61] libceph: un-backoff on tick when we have a authenticated session
Date: Mon, 30 Apr 2018 12:24:52 -0700
Message-Id: <20180430183955.481930116@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430183951.312721450@linuxfoundation.org>
References: <20180430183951.312721450@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200455140576288?=
X-GMAIL-MSGID: =?utf-8?q?1599200455140576288?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ilya Dryomov <idryomov@gmail.com>

commit facb9f6eba3df4e8027301cc0e514dc582a1b366 upstream.

This means that if we do some backoff, then authenticate, and are
healthy for an extended period of time, a subsequent failure won't
leave us starting our hunting sequence with a large backoff.

Mirrors ceph.git commit d466bc6e66abba9b464b0b69687cf45c9dccf383.

Cc: stable@vger.kernel.org # 4.7+
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Reviewed-by: Jason Dillaman <dillaman@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/ceph/mon_client.c |   13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

--- a/net/ceph/mon_client.c
+++ b/net/ceph/mon_client.c
@@ -209,6 +209,14 @@ static void reopen_session(struct ceph_m
 	__open_session(monc);
 }
 
+static void un_backoff(struct ceph_mon_client *monc)
+{
+	monc->hunt_mult /= 2; /* reduce by 50% */
+	if (monc->hunt_mult < 1)
+		monc->hunt_mult = 1;
+	dout("%s hunt_mult now %d\n", __func__, monc->hunt_mult);
+}
+
 /*
  * Reschedule delayed work timer.
  */
@@ -955,6 +963,7 @@ static void delayed_work(struct work_str
 		if (!monc->hunting) {
 			ceph_con_keepalive(&monc->con);
 			__validate_auth(monc);
+			un_backoff(monc);
 		}
 
 		if (is_auth) {
@@ -1114,9 +1123,7 @@ static void finish_hunting(struct ceph_m
 		dout("%s found mon%d\n", __func__, monc->cur_mon);
 		monc->hunting = false;
 		monc->had_a_connection = true;
-		monc->hunt_mult /= 2; /* reduce by 50% */
-		if (monc->hunt_mult < 1)
-			monc->hunt_mult = 1;
+		un_backoff(monc);
 	}
 }
 
