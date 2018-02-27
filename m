Return-Path: <keescook@chromium.org>
ARC-Seal: i=1; a=rsa-sha256; t=1519689871; cv=none;
        d=google.com; s=arc-20160816;
        b=EvZ09rCvoUDY3gxgq1af8pG/dWiuB7DMQdYspM1bJ8wp3/Oa6LlJqHXBt6+S9A3hRY
         RLfSg/F38vzJdqnUzHcn4OleRkFDKPoA2RwXdvFNd6p0rX0AgOzPXbUYy9093PMzrSI/
         vHX/a/3d8/W8TzPy5l/oFbx+zNS4Jkr3XCUWDhxvluzdO2bHY0TiiWhv/3LguDrJLNpl
         XsJJ2Q6asun2/i3vSkL0riRDTG2hvPhB2Ae1Jl2WoDT22eYBQ143aCvtPLFjhOrtWLba
         kmjRPIEyEeYS8sqf4HsDIIJAkAb8uSfd4K29/MO12haMKSkgDe6lbysIxNWRQsZZmWFM
         UtGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=dbqY1MtAK4aL/FBrzy4hA6hntGdRhdxi/aooZ+NhCdA=;
        b=dRpJL33hwKBcUMyoXH04kSHrUSMqLu+HzpzxWb0YuhxW8em93lsunxvIbCxSj8ki8f
         KOZ8fIX1ydSbrqmfhDOhJmxxh2zSqsHSKhCZTexROWk1scjx5N5HMkzRkXAW3Swqg1Mq
         fkJCuBANTtmy0NnlqiVB6o6FMyTfV0IIy+CB4PQeLAIr1gcIP9V4LU+YsYCLwTpgRlp6
         9zNsEGdjDXLoPp/LYnLa/EYydrkehG6GXroxWJ3GB6EiI3L4gR1pOyP6ZygNrHhlt7he
         n/NMHHX8lQFRllBVFjLUmsejLvsVWxsSlzlpyRsLE70nu29zxOJP+2ThArWIMAvTrMta
         xA/w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=DUBwFuNx;
       spf=pass (google.com: domain of keescook@chromium.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@chromium.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=DUBwFuNx;
       spf=pass (google.com: domain of keescook@chromium.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@chromium.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
X-Google-Smtp-Source: AH8x2273FYn0KILCPIFQ6NEdtHwj91S3YvBDoDuzizhE/RmzE0msR399dXw1n8SDoeZa9PUxS42fUg==
From: Kees Cook <keescook@chromium.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Kees Cook <keescook@chromium.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
	Nicolas Pitre <nicolas.pitre@linaro.org>,
	Thomas Winischhofer <thomas@winischhofer.net>,
	linux-usb@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] console: Fill in struct consw argument names
Date: Mon, 26 Feb 2018 16:04:19 -0800
Message-Id: <1519689860-7421-3-git-send-email-keescook@chromium.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519689860-7421-1-git-send-email-keescook@chromium.org>
References: <1519689860-7421-1-git-send-email-keescook@chromium.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593510326942047059?=
X-GMAIL-MSGID: =?utf-8?q?1593510326942047059?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Reading the function declarations for the console callbacks lacks any
hints as to what the arguments are. Instead of going and digging around in
various implementations that may each only have a subset of the callbacks,
name all the arguments in the declaration. This has no functional change.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/console.h | 58 +++++++++++++++++++++++++++----------------------
 1 file changed, 32 insertions(+), 26 deletions(-)

diff --git a/include/linux/console.h b/include/linux/console.h
index b8920a031a3e..dfd6b0e97855 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -46,46 +46,52 @@ enum con_scroll {
 struct consw {
 	struct module *owner;
 	const char *(*con_startup)(void);
-	void	(*con_init)(struct vc_data *, int);
-	void	(*con_deinit)(struct vc_data *);
-	void	(*con_clear)(struct vc_data *, int, int, int, int);
-	void	(*con_putc)(struct vc_data *, int, int, int);
-	void	(*con_putcs)(struct vc_data *, const unsigned short *, int, int, int);
-	void	(*con_cursor)(struct vc_data *, int);
-	bool	(*con_scroll)(struct vc_data *, unsigned int top,
+	void	(*con_init)(struct vc_data *vc, int init);
+	void	(*con_deinit)(struct vc_data *vc);
+	void	(*con_clear)(struct vc_data *vc, int sy, int sx, int height,
+			int width);
+	void	(*con_putc)(struct vc_data *vc, int c, int ypos, int xpos);
+	void	(*con_putcs)(struct vc_data *vc, const unsigned short *s,
+			int count, int ypos, int xpos);
+	void	(*con_cursor)(struct vc_data *vc, int mode);
+	bool	(*con_scroll)(struct vc_data *vc, unsigned int top,
 			unsigned int bottom, enum con_scroll dir,
 			unsigned int lines);
-	int	(*con_switch)(struct vc_data *);
-	int	(*con_blank)(struct vc_data *, int, int);
-	int	(*con_font_set)(struct vc_data *, struct console_font *, unsigned);
-	int	(*con_font_get)(struct vc_data *, struct console_font *);
-	int	(*con_font_default)(struct vc_data *, struct console_font *, char *);
-	int	(*con_font_copy)(struct vc_data *, int);
-	int     (*con_resize)(struct vc_data *, unsigned int, unsigned int,
-			       unsigned int);
-	void	(*con_set_palette)(struct vc_data *,
+	int	(*con_switch)(struct vc_data *vc);
+	int	(*con_blank)(struct vc_data *vc, int blank, int mode_switch);
+	int	(*con_font_set)(struct vc_data *vc, struct console_font *font,
+			unsigned int flags);
+	int	(*con_font_get)(struct vc_data *vc, struct console_font *font);
+	int	(*con_font_default)(struct vc_data *vc,
+			struct console_font *font, char *name);
+	int	(*con_font_copy)(struct vc_data *vc, int con);
+	int     (*con_resize)(struct vc_data *vc, unsigned int width,
+			unsigned int height, unsigned int user);
+	void	(*con_set_palette)(struct vc_data *vc,
 			const unsigned char *table);
-	void	(*con_scrolldelta)(struct vc_data *, int lines);
-	int	(*con_set_origin)(struct vc_data *);
-	void	(*con_save_screen)(struct vc_data *);
-	u8	(*con_build_attr)(struct vc_data *, u8, u8, u8, u8, u8, u8);
-	void	(*con_invert_region)(struct vc_data *, u16 *, int);
-	u16    *(*con_screen_pos)(struct vc_data *, int);
-	unsigned long (*con_getxy)(struct vc_data *, unsigned long, int *, int *);
+	void	(*con_scrolldelta)(struct vc_data *vc, int lines);
+	int	(*con_set_origin)(struct vc_data *vc);
+	void	(*con_save_screen)(struct vc_data *vc);
+	u8	(*con_build_attr)(struct vc_data *vc, u8 color, u8 intensity,
+			u8 blink, u8 underline, u8 reverse, u8 italic);
+	void	(*con_invert_region)(struct vc_data *vc, u16 *p, int count);
+	u16    *(*con_screen_pos)(struct vc_data *vc, int offset);
+	unsigned long (*con_getxy)(struct vc_data *vc, unsigned long position,
+			int *px, int *py);
 	/*
 	 * Flush the video console driver's scrollback buffer
 	 */
-	void	(*con_flush_scrollback)(struct vc_data *);
+	void	(*con_flush_scrollback)(struct vc_data *vc);
 	/*
 	 * Prepare the console for the debugger.  This includes, but is not
 	 * limited to, unblanking the console, loading an appropriate
 	 * palette, and allowing debugger generated output.
 	 */
-	int	(*con_debug_enter)(struct vc_data *);
+	int	(*con_debug_enter)(struct vc_data *vc);
 	/*
 	 * Restore the console to its pre-debug state as closely as possible.
 	 */
-	int	(*con_debug_leave)(struct vc_data *);
+	int	(*con_debug_leave)(struct vc_data *vc);
 };
 
 extern const struct consw *conswitchp;
-- 
2.7.4
