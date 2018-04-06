Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+bNjd/TajcRZx/4L/EtgCUP1J5ZqjwPtd4/gS6pqvPm7XRyc+Zn81UcK6B8PfRGkC6LnJs
ARC-Seal: i=1; a=rsa-sha256; t=1523021348; cv=none;
        d=google.com; s=arc-20160816;
        b=k+VmjIWRixvz3xugjiRzjWSdGSKyqcg4bbZssLwYu0HxKhpuuv0txkfxgvpH8YXhky
         fShUYKiCEXO2vRemKR76ogEQ9BfmTz2UkHbiMRv69DSEy/cRFO6oWMDd8h56pQJ483IN
         h01kyUx0I/jrQLqx2JhYBxUtAfrtTVnGn33SCLhfjFePWGKMV8As56W+mrvCF5ICCSma
         QkjjvRtmc+lzV/5Vl79kngXptVGY1bAi79OD2AIpXGiLDnzts84oNgSmJ/s6MRu3JRYU
         LdE2Ny7Sl4bylzIsmMzcY+gprMgRHr75guOcZrZFVoywTu5T9DvnaFGG8ICkj4dnKk9s
         qrkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=DDX/krr6ubyBt+3k2m56vwoL6YeiZjHpQ9SvOmWsWX4=;
        b=Zg2L63R/8kZGjc3iTxm57PcOpJjTJW0wLYYEYgZj4aFRlpJQ0CkD3uGd1pCtWC/IZr
         9af0gO3Yxn/Nf/sXFLTVWjmjIcZA8WJN7TZRSggC5HQi59Kce46uDybWXswXXb74ouBA
         hYp3eQS283cOLi1/1DssTozqk7y1cqUSk+zdFKW0IZc7CQEkPydwqr6Stb8wVACtbfE1
         HG5ipfL1vlkrRUf2Z9KvdbsgTznv6x1hSMp6OdnK+t+skxhtGF8TNJyETP1WIFzjBB4M
         IB18R1DFOjBXXT53VPAwUuT2OK2AXWdZm0NjXcLrXDJW5lDcjZlEiuUGx7CP89maLoh8
         7M1w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Mike Frysinger <vapier@chromium.org>
Subject: [PATCH 3.18 87/93] vt: change SGR 21 to follow the standards
Date: Fri,  6 Apr 2018 15:23:56 +0200
Message-Id: <20180406084228.982462269@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084224.918716300@linuxfoundation.org>
References: <20180406084224.918716300@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003632944142177?=
X-GMAIL-MSGID: =?utf-8?q?1597003632944142177?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1303,6 +1303,11 @@ static void csi_m(struct vc_data *vc)
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
@@ -1339,7 +1344,6 @@ static void csi_m(struct vc_data *vc)
 				vc->vc_disp_ctrl = 1;
 				vc->vc_toggle_meta = 1;
 				break;
-			case 21:
 			case 22:
 				vc->vc_intensity = 1;
 				break;
