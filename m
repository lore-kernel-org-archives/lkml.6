Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELttiF1F2gCTOnrJPqsTmu41dq8ixt1G1a50KekrWwiAwRZPoH4Sk82XkBI+7m0F2/2qmO7m
ARC-Seal: i=1; a=rsa-sha256; t=1519981211; cv=none;
        d=google.com; s=arc-20160816;
        b=eNtO0rmbpb2P3iON96Imq0lihEivOOdN4I2jWwWuxKNeHvBX5e5oAzBeczKkZlPgQs
         qmtiZaYY+/siczCFIDNUxLfPwcJsWVnNINkNl18RNx3lIobLFRh38VEUhPZi5vzc2J6f
         +tidJrK6jK6qiwE8uW2vYgDa4lKoduNNdJsFfwMdF1SMlufzhAkLBE9CrsM7U1GlSCZt
         cNZuzgBx5H86Pwnsl5JrXOJQhIKp5xWn2LzZsczK4aH5Dy8auIeUwY3rkD1iVBK1/72Z
         3dNxoiO6SEorpwzUStksmJfNASys+ef8LNKQocmJqLpOXNydLXhhBLwYyCJkX6jgW+Nz
         L7Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=aNNu6dPo29p0W8vZrYv0NGiHGi8dfmuylsbqBaoIjV8=;
        b=0rjgOFlnf3iwGw40QvYsYlXjS1FlGAqXO8GKFtXHK8ECvn3VfpLuM3Klpw9kjC1+do
         +4+sCCV2MsWvQ667TzSNb7SRuXKP6K2ec0aigvJT1OqL4moeEvy1G5bIkyj8OwU1sjg2
         VDYfM+rRBag+RqKVU0kCMEYtyhG2Sjqtz7jvy3PUOoFfXJBYwSVu2QtFon1m/W2Bu3+p
         VgOJZ09RcVcNOMzmL2DrXV+vfoUFqG+RSrSsE2e935lQWunNLfyDCdNJRGG92nb9mhKP
         G6JLgQLOa/gqfJfIhGvorvQcyrj3nnb4DJCuLZFJCASYngHHZGD7KtECOZEb3uKrCVFK
         aLUg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	James Smart <james.smart@broadcom.com>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 007/115] nvme-fc: remove double put reference if admin connect fails
Date: Fri,  2 Mar 2018 09:50:10 +0100
Message-Id: <20180302084504.154688765@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084503.856536800@linuxfoundation.org>
References: <20180302084503.856536800@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593815818981863605?=
X-GMAIL-MSGID: =?utf-8?q?1593815818981863605?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: James Smart <jsmart2021@gmail.com>


[ Upstream commit 4596e752db02d47038cd7c965419789ab15d1985 ]

There are two put references in the failure case of initial
create_association. The first put actually frees the controller, thus the
second put references freed memory.

Remove the unnecessary 2nd put.

Signed-off-by: James Smart <james.smart@broadcom.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/nvme/host/fc.c |    1 -
 1 file changed, 1 deletion(-)

--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2876,7 +2876,6 @@ nvme_fc_init_ctrl(struct device *dev, st
 
 		/* initiate nvme ctrl ref counting teardown */
 		nvme_uninit_ctrl(&ctrl->ctrl);
-		nvme_put_ctrl(&ctrl->ctrl);
 
 		/* Remove core ctrl ref. */
 		nvme_put_ctrl(&ctrl->ctrl);
