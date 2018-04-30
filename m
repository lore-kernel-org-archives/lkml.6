Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrObS57vKIQP7lFzN+BhDp/PGfsrNyzuQCH8DR1lLvvfVG3E5CQjJ4o9Q9r3mbhIvkvVV01
ARC-Seal: i=1; a=rsa-sha256; t=1525116520; cv=none;
        d=google.com; s=arc-20160816;
        b=lj8xzhTnA0ro9BcNnrfHNUtWathQvmLGPRXzrg4DkPv7PuzrmpcRFQKSNOMHqTNuXh
         DErfowCgS4koiBXMuZxqwe/vKwDS9+cGYTApmOUiwRV4wwpVqDEtCevMMQzKL987z//M
         5BFxvJUa9GIGwevyImquRWre3QTHQDQBGRkSEqoAMeaSgvCFDwgYaYBsTsJVPOiTYo2L
         Tl1TMR0P+38PjUhwAOQjKG0J5IZJoEltoQ/t71asKgF7Xy/92les9EUbX7+CO9TFedIU
         2xf6XcitJzUD1QMB0evULu26vno5dVZnloDWUAQ5gNQw6MaVnIElD3Q0wB6dgDNball+
         zsdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=fV289p77wYI00Q6xdprzD/1rv6aWJa50OgfTirzDpYM=;
        b=At7bBPOcr+0KVihCIjgM1i+ZZO3ZkP0RqaJucjfMzvRdc+NKO5NCuTNhACIxjn6wSn
         yvKPX/Jfi7yOXfGrW594UXNmSSxoqF+DeRZ08bCpArZuNMqhdhoXG0Odci4gnI+eRqCj
         F+0aAAVPmrL378ZVU4FfNM8dFjRiFyklTwphE64MVOsdguKM5uiK1j8HmaX+RzwT6yyo
         hiKqEbtaBSk4Yiiqh1qjiSeTdNG3JP5dn/gKnRLgLbuyYv263pswKveFSwT0410lPUh9
         yF1TRI7RxGeBrC7PP43LFt9QElzwyckXrW8sU5MJZSD22zVnj/v87IhQTitBViZKmTsS
         pM3Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E03B122DBF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Ilya Dryomov <idryomov@gmail.com>,
	Jason Dillaman <dillaman@redhat.com>
Subject: [PATCH 4.16 086/113] libceph: un-backoff on tick when we have a authenticated session
Date: Mon, 30 Apr 2018 12:24:57 -0700
Message-Id: <20180430184018.836367403@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430184015.043892819@linuxfoundation.org>
References: <20180430184015.043892819@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200455140576288?=
X-GMAIL-MSGID: =?utf-8?q?1599200580895958900?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
@@ -963,6 +971,7 @@ static void delayed_work(struct work_str
 		if (!monc->hunting) {
 			ceph_con_keepalive(&monc->con);
 			__validate_auth(monc);
+			un_backoff(monc);
 		}
 
 		if (is_auth &&
@@ -1123,9 +1132,7 @@ static void finish_hunting(struct ceph_m
 		dout("%s found mon%d\n", __func__, monc->cur_mon);
 		monc->hunting = false;
 		monc->had_a_connection = true;
-		monc->hunt_mult /= 2; /* reduce by 50% */
-		if (monc->hunt_mult < 1)
-			monc->hunt_mult = 1;
+		un_backoff(monc);
 	}
 }
 
