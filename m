Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752520AbeBCRmG (ORCPT <rfc822;w@1wt.eu>);
        Sat, 3 Feb 2018 12:42:06 -0500
Received: from mout.web.de ([217.72.192.78]:57456 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752235AbeBCRl5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Feb 2018 12:41:57 -0500
Subject: [PATCH 5/6] hid-prodikeys: Combine two condition checks into one
 statement in pcmidi_send_note()
From: SF Markus Elfring <elfring@users.sourceforge.net>
To: linux-input@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jikos@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <c388b4d8-fa43-1bf2-e27d-1a3a8d636118@users.sourceforge.net>
Message-ID: <9a241420-d47e-97ae-3d95-4fd59eda92ad@users.sourceforge.net>
Date: Sat, 3 Feb 2018 18:41:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <c388b4d8-fa43-1bf2-e27d-1a3a8d636118@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:XVcNeYMQQ13LNTz+XY9Bhk3S0ITZ/syDsDJysgF7/4cZM/G03yu
 UNQvgYl8Bi7zKxUjEOUQr0dbEtMHZdl9Mru6vF4jNLda4E/9SoxYegJxSVlX8w9SNQ8YUOe
 eBshbOCJkAnXByfv5k3u09YVQc0RpG1kc+vqFczMM+3UyI067PkEAVtdH6UfhwVoganlDb/
 CkMAdw7K8zf0Yam3UHcpg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:JVdffu13z9s=:sCdEbbAnnXqj4JbG7gHf7h
 EMcXM1LslrtFpcB7b0Kb0dlHwxMoOxW3YoyUiDpwMN/0LRkZMlK7V6+eFSF032sgyq9Dr5Nnm
 06JpXJaR7eGkFOQ5avGyboqZACSTc4f/br0zBfl4kMUKSXDZiDYzbEBeThEyPatPCEBdzNRll
 GxuDz9uU5pdANnKkD27mefdGZhcYPrB9fsz/ocbLGc1QjThelz6q2Sxux8DGZWZTI9+65oIzL
 X6QiYkFh4/NNxFzdoluB53epLKgNEkCvERSgijENcmN68gyi9jBgvsg2zKZm2GiCGwZ4gyajC
 tScBTnE+85Sf983BXyJ3whF9Ul/gJFjDDNF6SJcqCbPJ6IYxCGl+CDHLbMan1CbgBOCWRnDW0
 dekgzi2O9JoQvaa5GEeoKSkw45iJyHm2jNC0r7Q8T8Gdp0QdNVxkksyy+MwRve8a8SBDXZPVL
 zBWIUeweM7KUHJeSJ6EDvbvL/euEPfk8p04YJnOUilA48jVm4NctzCtPm381mBeQGkzCsmqQt
 1zL14YBxePp8dRbYvmShio6O8hPz7obcevXaiQL0rrI/fLJXyuZFsPK6GTjoao+jCzA5VqNwY
 j/z2arQSgK+NRjWjWa/icejzhX09o+jOpIvP7Y5Z9BpEPptlWgIPkNZruMj1nW1+zEwL6D2Vt
 zlKFiJZxpsJ1mpRXO2d44zKPIq774n6aImNNXEQJ9qew4+vdAF62Z4WiPi/YGto762vbeDqgy
 hb8edi7ZSsMmr/nGGNbuHC7njsPteY+ghX2qlKv8tiFKwjuePLnaohLjTNBqPO0nT0c6EAPPz
 eZCwGsH7Wslg6rcNiktXBimYEKn3RSCEqihqPT7GcM0e0ffoyw=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 3 Feb 2018 18:00:06 +0100

The same label was used by goto statements after two condition checks.
Thus use a single statement instead.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/hid/hid-prodikeys.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-prodikeys.c b/drivers/hid/hid-prodikeys.c
index c9eae92ad429..1c62dddedd40 100644
--- a/drivers/hid/hid-prodikeys.c
+++ b/drivers/hid/hid-prodikeys.c
@@ -226,9 +226,8 @@ static void pcmidi_send_note(struct pcmidi_snd *pm,
 
 	spin_lock_irqsave(&pm->rawmidi_in_lock, flags);
 
-	if (!pm->in_substream)
-		goto drop_note;
-	if (!test_bit(pm->in_substream->number, &pm->in_triggered))
+	if (!pm->in_substream ||
+	    !test_bit(pm->in_substream->number, &pm->in_triggered))
 		goto drop_note;
 
 	snd_rawmidi_receive(pm->in_substream, buffer, 3);
-- 
2.16.1
