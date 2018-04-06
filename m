Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48AjdrvUzvjHIyZehucEL1A2xxL70mU4GPbMosU0B7/I6JMynVVAp2+8kwtYqKKQdyyu4n6
ARC-Seal: i=1; a=rsa-sha256; t=1523021493; cv=none;
        d=google.com; s=arc-20160816;
        b=JeclaxtJ8XyHG1pq3pyKcNZAFJuI0rksMRUhpDNoFdDuvpBqXyLll+FgWRbMuFCgqz
         Zc3xKw+RhHOVTagqdiVsmIJdoobnOge6EKcI6eVZRbRNVbDZ60RuA96Sq6gJcOPzzKd8
         DdzZeTKeRzvIjQR6xxcKb8Tid3QkG0oPHTeO+AjJsbb6+dUI8anA/lkwaIb2W6Woh1YJ
         DjZWb9fnQUtoWNeaRJgmR9hVOwvBZt0IGZQxP05pWv+D0N2B48CwgJAWTRlItWmI1LlW
         B03u5mahVzt8n64KqaHUi3ZgyIB6/NWm3Wt4/YZzVDduhUC6AvjWmTUOtup4ob4FVl3R
         QwHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=HJjjb8DxBd2/3+wzbM6ueXkbT4xKMieUkJwpFNeggKU=;
        b=AibeEU6YOXB/3MeFb+TzEGYc4VdDamDfIhsf9BUfYD8D7oqM9l2SxZETMKUcw0puaq
         i59PBJrLbFhIXKftV9NshWrPEfQnCMjtBD2qzISM7TD7NZg0J/hk1Vj8veowWNo+Bqg1
         9W/JluMbjgv4A4BABgOmXHjzt8UGUxDF5Vq4KwQBPoYpKz+tGBPjwHuFHi9JFkewbWxn
         C5VFEI0otw5wrnBCCGvWvx5/4Ofv5EUfFTtUMnxr80oy2vTOGMRVy27eLKfbxbeHuXeS
         qQ4lUrF0MHNgpS6tXc8SOQC5TvQ51YwNArVm14FXHqY2AyZVkSMDzc2f5ECkrP8Hfyp5
         9YhA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Mike Frysinger <vapier@chromium.org>
Subject: [PATCH 4.4 57/72] vt: change SGR 21 to follow the standards
Date: Fri,  6 Apr 2018 15:23:58 +0200
Message-Id: <20180406084310.094851516@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084305.210085169@linuxfoundation.org>
References: <20180406084305.210085169@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003632944142177?=
X-GMAIL-MSGID: =?utf-8?q?1597003785408211096?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mike Frysinger <vapier@chromium.org>

commit 65d9982d7e523a1a8e7c9af012da0d166f72fc56 upstream.

ECMA-48 [1] (aka ISO 6429) has defined SGR 21 as "doubly underlined"
since at least March 1984.  The Linux kernel has treated it as SGR 22
"normal intensity" since it was added in Linux-0.96b in June 1992.
Before that, it was simply ignored.  Other terminal emulators have
either ignored it, or treat it as double underline now.  xterm for
example added support in its 304 release (May 2014) [2] where it was
previously ignoring it.

Changing this behavior shouldn't be an issue:
- It isn't a named capability in ncurses's terminfo database, so no
  script is using libtinfo/libcurses to look this up, or using tput
  to query & output the right sequence.
- Any script assuming SGR 21 will reset intensity in all terminals
  already do not work correctly on non-Linux VTs (including running
  under screen/tmux/etc...).
- If someone has written a script that only runs in the Linux VT, and
  they're using SGR 21 (instead of SGR 22), the output should still
  be readable.

imo it's important to change this as the Linux VT's non-conformance
is sometimes used as an argument for other terminal emulators to not
implement SGR 21 at all, or do so incorrectly.

[1]: https://www.ecma-international.org/publications/standards/Ecma-048.htm
[2]: https://github.com/ThomasDickey/xterm-snapshots/commit/2fd29cb98d214cb536bcafbee00bc73b3f1eeb9d

Signed-off-by: Mike Frysinger <vapier@chromium.org>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/tty/vt/vt.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -1312,6 +1312,11 @@ static void csi_m(struct vc_data *vc)
 			case 3:
 				vc->vc_italic = 1;
 				break;
+			case 21:
+				/*
+				 * No console drivers support double underline, so
+				 * convert it to a single underline.
+				 */
 			case 4:
 				vc->vc_underline = 1;
 				break;
@@ -1348,7 +1353,6 @@ static void csi_m(struct vc_data *vc)
 				vc->vc_disp_ctrl = 1;
 				vc->vc_toggle_meta = 1;
 				break;
-			case 21:
 			case 22:
 				vc->vc_intensity = 1;
 				break;
