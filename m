Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZocoj3dcny+GeX650HeFye3SCYyQa1fa/MkuahK8q814BjqgAej0iAXXdk2o+Ll1IS3ZBH9
ARC-Seal: i=1; a=rsa-sha256; t=1525116401; cv=none;
        d=google.com; s=arc-20160816;
        b=aYS5HGo9cj13m2MQpkpXjAbGXKmzalXDOpZG0XZ0XZgeIsQwZUO3HFX9Dau43q9ON8
         i+EW7XALQ6ZdcPi/sVg+29eg7ptB0woTI+DgR0RNDlBqj+KeLEDfIyJHqdAtJybzXYtJ
         IyzwiK5JTpK+Dd1ZdUgddvxAr40gu0L7P38dGg9q1933oOf5aVSt/8jcgM/vxWHLuT7c
         4ZItJUs4RVk9xCQgiCm6N1F/cIWqKQR/iiOKx7MA0XjyxeC6UNcq+rrTpeYWRQTqvbX9
         Myh2LtzYLGcmC5G9crbzJj6xsKq5Mks0X82j+b1CTUcuC7iS5/iUfII0T/MpNFyS/lA9
         ZVsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=xD06JwWD0c0ozgSw9WhKJa/nZrfbZfmRWQx7Cluv/w0=;
        b=T5Y5Fwsx70W7fdlkPYUbN1u+lO6BYAFoI/25BiCiqEhVuLUejl2yliRgoUgUJG+y9/
         eowVGVlyfJfdrb/g7pUiz1FvlyN89CAbkXg8gHv8cj4vo3NW/We2inZYiB7cI9yHaKwz
         iH3o0dSdDTQQANhYcvKkoowE/L44SHLJl0kPra8goFOeJ8s5zMDho+E/3oMCSxy2UzQL
         FFU19qPw9IOFI79il68j/Iv6RBQjk7g/OY3uC9p8CfvlTlll/746z5fQR7o7SPdcDc/w
         /j7WtmV4tovDAz8YxTpGSjmrVxWzzOhFoQwWoEsgMbXobybdo9Jukh2F1SoQ8kAy45YP
         6r9A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBA0722DAE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Ilya Dryomov <idryomov@gmail.com>,
	Jason Dillaman <dillaman@redhat.com>
Subject: [PATCH 4.9 50/61] libceph: reschedule a tick in finish_hunting()
Date: Mon, 30 Apr 2018 12:24:53 -0700
Message-Id: <20180430183955.562969932@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430183951.312721450@linuxfoundation.org>
References: <20180430183951.312721450@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200581417359909?=
X-GMAIL-MSGID: =?utf-8?q?1599200455794758658?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1124,6 +1124,7 @@ static void finish_hunting(struct ceph_m
 		monc->hunting = false;
 		monc->had_a_connection = true;
 		un_backoff(monc);
+		__schedule_delayed(monc);
 	}
 }
 
