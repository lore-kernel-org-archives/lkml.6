Return-Path: <ben@decadent.org.uk>
X-Google-Smtp-Source: AH8x225FYX9rjXjdnBDSxaBBmXJqk3xGVX2P5t80ornE61pOOikGpdPDhb1YsOeSHoXwAGiQF+oB
ARC-Seal: i=1; a=rsa-sha256; t=1518323637; cv=none;
        d=google.com; s=arc-20160816;
        b=Yp2zQi1R12Wv7IpgMUhtCgecWNQotY0iVR5kgqGUWRbz31UBFF8fC5eF5qrECW9g6F
         LZ6/HDkkb9vhDSbWL4orWqxEWRhRLxwFEy/laobh6ttxpRLGSYuV7vtfKYEiESS1djEH
         8Z2QLwKh+L9cUFI5UEWjxIEWz8butlIiMB7PuW+ndeG05Qd2khz5FtBElx8kXG5imGSw
         SvrpYDT/YFD4R/3fIwM0Zt4MLBaNugh0xIAvgLIwFHuFudKgviNCtT8LAuIsGib8cdHw
         h4U84uBXUMEPupPXhOYx8HzyUPukSLoXU1Icjw/21rWczY7EuTvt7oN6HoKj9vNnCB1m
         0leg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:subject:message-id:date:cc:to:from:mime-version
         :content-transfer-encoding:content-disposition
         :arc-authentication-results;
        bh=OlbzZnp2MGbCOKp8VINtpW0Lu1AbUzDdIieAJtUUlio=;
        b=ytp7P2ggZez46afxsQGG0wC56tQWxy8r858sVC7zRLHRFHwRT/YPhlUNVboJKEri0B
         zvv449Koy9VRSYQ2HUfu/IvjWYIlmlTH+AoBGgaweuTXs34e9oNcJAET4sMagEgwWRi4
         Tk7eZpaDxyypilLidwjLCq+11aTMDyrM9rLkOl9g3PLSa5MaRTH9qys9uCazyRTBMcA3
         p5A7N1jwCyZa4xeWW2KBPU9dopWy0nMgHlyVHoL9WobL+A8o2zi/xWXHkJ83uNstVRe6
         W7LY7Dpd3jUySJu129uP1thIuOtC4YFaLscJvSa60BnGKGQLQn8WPxJdt/BY4dHTIICO
         PdWQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of ben@decadent.org.uk designates 88.96.1.126 as permitted sender) smtp.mailfrom=ben@decadent.org.uk
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of ben@decadent.org.uk designates 88.96.1.126 as permitted sender) smtp.mailfrom=ben@decadent.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
 "Ben Seri" <ben@armis.com>,
 "Johan Hedberg" <johan.hedberg@gmail.com>,
 "Marcel Holtmann" <marcel@holtmann.org>,
 "Gustavo Padovan" <gustavo@padovan.org>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Date: Sun, 11 Feb 2018 04:31:11 +0000
Message-ID: <lsq.1518323471.227276522@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 118/136] Bluetooth: Prevent stack info leak from the
 EFS element.
In-Reply-To: <lsq.1518323469.348919605@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592077726361800285?=
X-GMAIL-MSGID: =?utf-8?q?1592077726361800285?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.54-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Ben Seri <ben@armis.com>

commit 06e7e776ca4d36547e503279aeff996cbb292c16 upstream.

In the function l2cap_parse_conf_rsp and in the function
l2cap_parse_conf_req the following variable is declared without
initialization:

struct l2cap_conf_efs efs;

In addition, when parsing input configuration parameters in both of
these functions, the switch case for handling EFS elements may skip the
memcpy call that will write to the efs variable:

...
case L2CAP_CONF_EFS:
if (olen == sizeof(efs))
memcpy(&efs, (void *)val, olen);
...

The olen in the above if is attacker controlled, and regardless of that
if, in both of these functions the efs variable would eventually be
added to the outgoing configuration request that is being built:

l2cap_add_conf_opt(&ptr, L2CAP_CONF_EFS, sizeof(efs), (unsigned long) &efs);

So by sending a configuration request, or response, that contains an
L2CAP_CONF_EFS element, but with an element length that is not
sizeof(efs) - the memcpy to the uninitialized efs variable can be
avoided, and the uninitialized variable would be returned to the
attacker (16 bytes).

This issue has been assigned CVE-2017-1000410

Cc: Marcel Holtmann <marcel@holtmann.org>
Cc: Gustavo Padovan <gustavo@padovan.org>
Cc: Johan Hedberg <johan.hedberg@gmail.com>
Signed-off-by: Ben Seri <ben@armis.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/bluetooth/l2cap_core.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -3349,9 +3349,10 @@ static int l2cap_parse_conf_req(struct l
 			break;
 
 		case L2CAP_CONF_EFS:
-			remote_efs = 1;
-			if (olen == sizeof(efs))
+			if (olen == sizeof(efs)) {
+				remote_efs = 1;
 				memcpy(&efs, (void *) val, olen);
+			}
 			break;
 
 		case L2CAP_CONF_EWS:
@@ -3570,16 +3571,17 @@ static int l2cap_parse_conf_rsp(struct l
 			break;
 
 		case L2CAP_CONF_EFS:
-			if (olen == sizeof(efs))
+			if (olen == sizeof(efs)) {
 				memcpy(&efs, (void *)val, olen);
 
-			if (chan->local_stype != L2CAP_SERV_NOTRAFIC &&
-			    efs.stype != L2CAP_SERV_NOTRAFIC &&
-			    efs.stype != chan->local_stype)
-				return -ECONNREFUSED;
+				if (chan->local_stype != L2CAP_SERV_NOTRAFIC &&
+				    efs.stype != L2CAP_SERV_NOTRAFIC &&
+				    efs.stype != chan->local_stype)
+					return -ECONNREFUSED;
 
-			l2cap_add_conf_opt(&ptr, L2CAP_CONF_EFS, sizeof(efs),
-					   (unsigned long) &efs, endptr - ptr);
+				l2cap_add_conf_opt(&ptr, L2CAP_CONF_EFS, sizeof(efs),
+						   (unsigned long) &efs, endptr - ptr);
+			}
 			break;
 
 		case L2CAP_CONF_FCS:
