Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELu3KRbm7S8tElqXfkgX3n8VQ67OgTOQtJBG6oVtB9qrFX4wrA1fbe45nR9zSnscNayWeAXE
ARC-Seal: i=1; a=rsa-sha256; t=1521483085; cv=none;
        d=google.com; s=arc-20160816;
        b=0MBZHLCyydH2aL9C3kPoTVTBLyrW9U7EiEQf8TqQr2JYKbLd4ncMKHYYHr2IyEHl3K
         KighTbSRWBUAnlUNKeFJGZuI89xBqLR/4nEEhfEpIlz2NH37+Thg3SbXf0iAXCuyF7b0
         57vPiVUcqWtMkl+74ALMV6irbvQWT+wrnlH3NcWnmM3puyetfMvNW4aX2BZuJPuWRGIS
         p+F+NU9l06xmYkpaF0Mfi+zy6tHcj2gtiK177/GS+JfBi2gLTeZRNauYV16GNX7GWc7z
         /T2U09ImeZeSu+JKAH414SLIVHV3djH+1WFuOZ5+1i/EGFURLbqrFlQD1KRFfYJCg8C7
         0MbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=AP20q2zVlYEVe26V43dbe8+aBtY2wQDJkubvDame8OI=;
        b=HZrITw41dGQcdnFHqiZhNUYJDirduC/qcHYGJrxKQAJl91fzxEeM0c2JDNVnxi2tLG
         QnVFyx5rVFz31nRkGIjv0SDQxuDVavocAiC2mvfoo+XCoQdVgSLsH62eLoXhbGwG66mx
         K9fa6aUE+V1UdqVSADPZ2u7BSoa6MU+TkXeWb/wgP3zLzbVat8VgIoeyvtg2Ij5ebY4r
         XikvuusKVikbHBBoU/OSASJthDcFtW0+zuOs6+JZE5OaWRO+1YdrRJmuPEsVpqpKmAkA
         3I60SFlEJkhtdePkdALTyJN/LYJOn/3gpdyio7byI04CmN9GqbDJEfYNnm5zDoAE3LBN
         ECqw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 3.18 62/68] ALSA: seq: Clear client entry before deleting else at closing
Date: Mon, 19 Mar 2018 19:06:40 +0100
Message-Id: <20180319171836.577285981@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319171827.899658615@linuxfoundation.org>
References: <20180319171827.899658615@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390647940605831?=
X-GMAIL-MSGID: =?utf-8?q?1595390647940605831?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

commit a2ff19f7b70118ced291a28d5313469914de451b upstream.

When releasing a client, we need to clear the clienttab[] entry at
first, then call snd_seq_queue_client_leave().  Otherwise, the
in-flight cell in the queue might be picked up by the timer interrupt
via snd_seq_check_queue() before calling snd_seq_queue_client_leave(),
and it's delivered to another queue while the client is clearing
queues.  This may eventually result in an uncleared cell remaining in
a queue, and the later snd_seq_pool_delete() may need to wait for a
long time until the event gets really processed.

By moving the clienttab[] clearance at the beginning of release, any
event delivery of a cell belonging to this client will fail at a later
point, since snd_seq_client_ptr() returns NULL.  Thus the cell that
was picked up by the timer interrupt will be returned immediately
without further delivery, and the long stall of snd_seq_delete_pool()
can be avoided, too.

Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/core/seq/seq_clientmgr.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/sound/core/seq/seq_clientmgr.c
+++ b/sound/core/seq/seq_clientmgr.c
@@ -270,12 +270,12 @@ static int seq_free_client1(struct snd_s
 
 	if (!client)
 		return 0;
-	snd_seq_delete_all_ports(client);
-	snd_seq_queue_client_leave(client->number);
 	spin_lock_irqsave(&clients_lock, flags);
 	clienttablock[client->number] = 1;
 	clienttab[client->number] = NULL;
 	spin_unlock_irqrestore(&clients_lock, flags);
+	snd_seq_delete_all_ports(client);
+	snd_seq_queue_client_leave(client->number);
 	snd_use_lock_sync(&client->use_lock);
 	snd_seq_queue_client_termination(client->number);
 	if (client->pool)
