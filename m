Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuQQOGNvnFFqnwKlYXEML0sc6FBJi9hgCKAjomXLShLVmhpoIHR8tDAOS4kujVv4QzFA0/p
ARC-Seal: i=1; a=rsa-sha256; t=1521484080; cv=none;
        d=google.com; s=arc-20160816;
        b=LglYMK/eCApLY7xcvGT9WALLBC6okbgQVfGuOXolD8pF290eOA49QBDyNOVtVdZmb4
         eg1w9gN/vBSyg4Nxjctzb4jvYP3gIycKK3Qz4Jnr/xD5Z4TMJTzWvb/Gf4rKTgmWSqEO
         qk4qiPYHx7YY+ZO3cbV+JtSEHfeo7uu9mI8JPPD9airQRjcWvKdxIBtQCslsM5LVpsLb
         pJeUlj5q6H74dZB3ScDgscrnkcmcAYtVkG/h6w47fn+ItWz+xP9/+oYzoaD+6gGPjJ12
         Q0Ai7nqER7CFIghY5uJcjbqxahYfADYJb54rrdE0hDHmEtzNpkGhmsHS3tTYOyl6RcDF
         pGyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=3V7aeG/qVk1ViPaXlsE0fOO9XPKX2ZZmbXlYY1qumzw=;
        b=iFmhb/DIIO5wF9Xyx9vW7FDUl/PIZcjBRQEywQIvJ4/lc8ciYvFhDYLD+0SeW0PuA7
         LwUrsptHD5Tkw9EHqUSbpId8gU/BVVXt9dOJMUfJChjic6+yRgV54Z91VTHBmP7LDA5S
         VPc54OY/5BACuzi/8uQs//RINyytQ9XTUX416O0odOfXM7gRRNzwrHBgxGT0diaGtPiw
         Vj8KpNqXnka+YRyOF5p9r5R1aUiMlfOaSSWThjJMAIQZqf/8DtqQZvlInG+K51/dDCgD
         QtJHLr3xahvKnKskArUm3obx251ZXxLeb1Kg/FMFYzp97e8a91tDh5TMsSe+lxM520FX
         /jmQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.9 225/241] ALSA: seq: Clear client entry before deleting else at closing
Date: Mon, 19 Mar 2018 19:08:10 +0100
Message-Id: <20180319180800.488107639@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390647940605831?=
X-GMAIL-MSGID: =?utf-8?q?1595391690691373700?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -255,12 +255,12 @@ static int seq_free_client1(struct snd_s
 
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
