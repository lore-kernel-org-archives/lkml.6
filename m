Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrINcYV3f5Pxl4MTpRURnTsOHvD/tSuvJ7jfWGM1WQEAv49V8Hx+bk/nDN/LmD28G44YUHg
ARC-Seal: i=1; a=rsa-sha256; t=1525116455; cv=none;
        d=google.com; s=arc-20160816;
        b=R8UXh5betI79794Xm7HbpJd8LVe9xEkso+j4DDwAS135vH8gD1XuaCDOFgZdOK6B2v
         yomUEwBFsAazB7zs85czScb84HhuTs9BryYvLwLPyycCow0cfB4hQ7ChGUN4fhQktC2+
         RiNRcQhfL6Ycwh7g3DoZQhNJY0WfodPuCiit27sBxcjy0d+d8e3AL11OP36fpGDBXsQj
         bYf5QIdKGxTnR10CsktR4lWzMQOd6RtbSorqZTPeut5ceydK3OIqkLzsFa5Q7UIC4lMU
         Awe3hK2H/G1mg7qWe1/eLP5awFcLdxMeBN47gxfUbvoIFGm3gu35ZQ1dFTw/zr7lortf
         mEFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=IYU0uE/XJA30o+SK7W6q/gGwTzZ5nepqL9dFMRdICfg=;
        b=osxfjiEI+k8OeHoSju/iRAKw/bLjNMXnAgiOmmDY0EyuOwRNaG8Wrf0KzR5ISNCs6e
         EkAy49JMI6yuV8mzmOLKpmvDM0kCyan6BTUOKdrVgaWgf0vr6IFvmV6ZHApLV/lcoo/R
         PQkUpQs8v6EF3zy4cmT+wso90xl0651SAmt732GWs0cAtRJWGOe+PvgSKL3c7h7qaw6H
         4NoGlQOcPkLvF69llV0W/8x6iRpr1BXxfs2lpr2ufFmQKp3TcWH8w/8HQgxb5VuSzoud
         wEnLFSQQVnJzGVVy0v6UpUc8iguMyk9enaaJiOQXnaYyPfRo/oe2NZz594hsUUskGsMz
         aQ+Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C67E22DCC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Ilya Dryomov <idryomov@gmail.com>,
	Jason Dillaman <dillaman@redhat.com>
Subject: [PATCH 4.14 74/91] libceph: reschedule a tick in finish_hunting()
Date: Mon, 30 Apr 2018 12:24:56 -0700
Message-Id: <20180430184008.125080894@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430184004.216234025@linuxfoundation.org>
References: <20180430184004.216234025@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200581417359909?=
X-GMAIL-MSGID: =?utf-8?q?1599200512452052217?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ilya Dryomov <idryomov@gmail.com>

commit 7b4c443d139f1d2b5570da475f7a9cbcef86740c upstream.

If we go without an established session for a while, backoff delay will
climb to 30 seconds.  The keepalive timeout is also 30 seconds, so it's
pretty easily hit after a prolonged hunting for a monitor: we don't get
a chance to send out a keepalive in time, which means we never get back
a keepalive ack in time, cutting an established session and attempting
to connect to a different monitor every 30 seconds:

  [Sun Apr 1 23:37:05 2018] libceph: mon0 10.80.20.99:6789 session established
  [Sun Apr 1 23:37:36 2018] libceph: mon0 10.80.20.99:6789 session lost, hunting for new mon
  [Sun Apr 1 23:37:36 2018] libceph: mon2 10.80.20.103:6789 session established
  [Sun Apr 1 23:38:07 2018] libceph: mon2 10.80.20.103:6789 session lost, hunting for new mon
  [Sun Apr 1 23:38:07 2018] libceph: mon1 10.80.20.100:6789 session established
  [Sun Apr 1 23:38:37 2018] libceph: mon1 10.80.20.100:6789 session lost, hunting for new mon
  [Sun Apr 1 23:38:37 2018] libceph: mon2 10.80.20.103:6789 session established
  [Sun Apr 1 23:39:08 2018] libceph: mon2 10.80.20.103:6789 session lost, hunting for new mon

The regular keepalive interval is 10 seconds.  After ->hunting is
cleared in finish_hunting(), call __schedule_delayed() to ensure we
send out a keepalive after 10 seconds.

Cc: stable@vger.kernel.org # 4.7+
Link: http://tracker.ceph.com/issues/23537
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Reviewed-by: Jason Dillaman <dillaman@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/ceph/mon_client.c |    1 +
 1 file changed, 1 insertion(+)

--- a/net/ceph/mon_client.c
+++ b/net/ceph/mon_client.c
@@ -1133,6 +1133,7 @@ static void finish_hunting(struct ceph_m
 		monc->hunting = false;
 		monc->had_a_connection = true;
 		un_backoff(monc);
+		__schedule_delayed(monc);
 	}
 }
 
