Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvC5DI+mudaxoQkPjTMnOs66pMHsaFiqWI5WLPgWziNSnuNDN2PRfLoT31T9fXf+CJGG+9N
ARC-Seal: i=1; a=rsa-sha256; t=1521483769; cv=none;
        d=google.com; s=arc-20160816;
        b=pAVc/onPr4ptnioeTv1b0aHGEQkJ2A1NhB1tQ/itVsL5PX4WNq1B0qPfL1hdiceFBl
         hTy6yM59IBt1LUCl4l7NJZBNQWRR+BnKyxw4i1XX4hLqUGaszWg2EIleV/tUzCHL+DZz
         vmpIHUjCNZdqYloMXDBGq4x8Dtkjtw2F11EDrhwjYDdLJnjQA63npC5+9JDjGiuoZ9in
         PK+HzuoROqF+FH25qT8iLFqQc69peWBynhUFtFdOTJNwbmvKNIR223LDOFaSGG9Hv3dU
         1LRYV4kiVGJGI912Km9QeL2SCDO4LCvG5Xv+Hq49vYQNS5Fl3DofS1mXcqBwgZKJVX8e
         oGrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=3CPQhkEBtU67iX9JuPyp2NdLd3/l5RM9ZnEh14bDyfg=;
        b=sCiKiGdvjS7Am1iIqZPSP3AtYDzdRp8o8cKUUJrdjTHfQCQB04LlOyehEULqMe5fpl
         usJdwecaxAmbFQBygSjil7N2Fpfk6clz8SyscRcB8Ddw7bQFaJKOF0+GHNNnO0eDNSgY
         RnntGyHMq973rhgxQVR+wqsmsdL1VwXBiHDa9uR8VyvGj3ijNjJgqJsQWKhdlJqWZk4X
         NQ9NwWN5KPx4Y/1uGStWsfQxrjyzjydQ7T31F5t5rypmK2Hiim92MP8n33GSAc3Jc7p/
         90BMN/gZFGq5ZEyQRJbCFbrNyt9DKQMm8lTNdaS6B5FVgquvee+nQDy7bSLgzOJf+cAK
         loTg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Takashi Sakamoto <o-takashi@sakamocchi.jp>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 111/241] ALSA: firewire-digi00x: handle all MIDI messages on streaming packets
Date: Mon, 19 Mar 2018 19:06:16 +0100
Message-Id: <20180319180755.809983705@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390814861636073?=
X-GMAIL-MSGID: =?utf-8?q?1595391364727062881?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Sakamoto <o-takashi@sakamocchi.jp>


[ Upstream commit 8820a4cf0cb4cd5c6540a9a18b2cedbdfd5a6891 ]

At a commit 9dc5d31cdceb ("ALSA: firewire-digi00x: handle MIDI messages in
isochronous packets"), a functionality to handle MIDI messages on
isochronous packet was supported. But this includes some of my
misunderstanding. This commit is to fix them.

For digi00x series, first data channel of data blocks in rx/tx packet
includes MIDI messages. The data channel has 0x80 in 8 bit of its MSB,
however it's against IEC 61883-6. Unique data format is applied:
 - Upper 4 bits of LSB represent port number.
  - 0x0: port 1.
  - 0x2: port 2.
  - 0xe: console port.
 - Lower 4 bits of LSB represent the number of included MIDI message bytes;
   0x0/0x1/0x2.
 - Two bytes of middle of this data channel have MIDI bytes.

Especially, MIDI messages from/to console surface are also transferred by
isochronous packets, as well as physical MIDI ports.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/firewire/digi00x/amdtp-dot.c |   53 +++++++++++++++++++++++++------------
 1 file changed, 36 insertions(+), 17 deletions(-)

--- a/sound/firewire/digi00x/amdtp-dot.c
+++ b/sound/firewire/digi00x/amdtp-dot.c
@@ -28,6 +28,9 @@
  */
 #define MAX_MIDI_RX_BLOCKS	8
 
+/* 3 = MAX(DOT_MIDI_IN_PORTS, DOT_MIDI_OUT_PORTS) + 1. */
+#define MAX_MIDI_PORTS		3
+
 /*
  * The double-oh-three algorithm was discovered by Robin Gareus and Damien
  * Zammit in 2012, with reverse-engineering for Digi 003 Rack.
@@ -42,10 +45,8 @@ struct amdtp_dot {
 	unsigned int pcm_channels;
 	struct dot_state state;
 
-	unsigned int midi_ports;
-	/* 2 = MAX(DOT_MIDI_IN_PORTS, DOT_MIDI_OUT_PORTS) */
-	struct snd_rawmidi_substream *midi[2];
-	int midi_fifo_used[2];
+	struct snd_rawmidi_substream *midi[MAX_MIDI_PORTS];
+	int midi_fifo_used[MAX_MIDI_PORTS];
 	int midi_fifo_limit;
 
 	void (*transfer_samples)(struct amdtp_stream *s,
@@ -124,8 +125,8 @@ int amdtp_dot_set_parameters(struct amdt
 		return -EBUSY;
 
 	/*
-	 * A first data channel is for MIDI conformant data channel, the rest is
-	 * Multi Bit Linear Audio data channel.
+	 * A first data channel is for MIDI messages, the rest is Multi Bit
+	 * Linear Audio data channel.
 	 */
 	err = amdtp_stream_set_parameters(s, rate, pcm_channels + 1);
 	if (err < 0)
@@ -135,11 +136,6 @@ int amdtp_dot_set_parameters(struct amdt
 
 	p->pcm_channels = pcm_channels;
 
-	if (s->direction == AMDTP_IN_STREAM)
-		p->midi_ports = DOT_MIDI_IN_PORTS;
-	else
-		p->midi_ports = DOT_MIDI_OUT_PORTS;
-
 	/*
 	 * We do not know the actual MIDI FIFO size of most devices.  Just
 	 * assume two bytes, i.e., one byte can be received over the bus while
@@ -281,13 +277,25 @@ static void write_midi_messages(struct a
 		b = (u8 *)&buffer[0];
 
 		len = 0;
-		if (port < p->midi_ports &&
+		if (port < MAX_MIDI_PORTS &&
 		    midi_ratelimit_per_packet(s, port) &&
 		    p->midi[port] != NULL)
 			len = snd_rawmidi_transmit(p->midi[port], b + 1, 2);
 
 		if (len > 0) {
-			b[3] = (0x10 << port) | len;
+			/*
+			 * Upper 4 bits of LSB represent port number.
+			 * - 0000b: physical MIDI port 1.
+			 * - 0010b: physical MIDI port 2.
+			 * - 1110b: console MIDI port.
+			 */
+			if (port == 2)
+				b[3] = 0xe0;
+			else if (port == 1)
+				b[3] = 0x20;
+			else
+				b[3] = 0x00;
+			b[3] |= len;
 			midi_use_bytes(s, port, len);
 		} else {
 			b[1] = 0;
@@ -309,11 +317,22 @@ static void read_midi_messages(struct am
 
 	for (f = 0; f < data_blocks; f++) {
 		b = (u8 *)&buffer[0];
-		port = b[3] >> 4;
+
 		len = b[3] & 0x0f;
+		if (len > 0) {
+			/*
+			 * Upper 4 bits of LSB represent port number.
+			 * - 0000b: physical MIDI port 1. Use port 0.
+			 * - 1110b: console MIDI port. Use port 2.
+			 */
+			if (b[3] >> 4 > 0)
+				port = 2;
+			else
+				port = 0;
 
-		if (port < p->midi_ports && p->midi[port] && len > 0)
-			snd_rawmidi_receive(p->midi[port], b + 1, len);
+			if (port < MAX_MIDI_PORTS && p->midi[port])
+				snd_rawmidi_receive(p->midi[port], b + 1, len);
+		}
 
 		buffer += s->data_block_quadlets;
 	}
@@ -364,7 +383,7 @@ void amdtp_dot_midi_trigger(struct amdtp
 {
 	struct amdtp_dot *p = s->protocol;
 
-	if (port < p->midi_ports)
+	if (port < MAX_MIDI_PORTS)
 		ACCESS_ONCE(p->midi[port]) = midi;
 }
 
