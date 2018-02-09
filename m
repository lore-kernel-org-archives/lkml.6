Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751060AbeBIG6l (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 01:58:41 -0500
Received: from mail-qk0-f194.google.com ([209.85.220.194]:37860 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750909AbeBIG6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 01:58:39 -0500
X-Google-Smtp-Source: AH8x22778d3QlP7at2PW71HxO3GKJ8lOVAt5TUeqcIsvKdI8/qE6EJnaK8WMQKajZNXhgKH2NEITjFXKhM4Dg6Q4IqY=
MIME-Version: 1.0
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Fri, 9 Feb 2018 14:58:18 +0800
Message-ID: <CAErzpmuKgMyxascCdq3KuF1F1K4e2ciZq7FKsOha6WSBgg-WYw@mail.gmail.com>
Subject: [PATCH] ASoC: use DEFINE_SHOW_ATTRIBUTE() to decrease code duplication
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is some duplicate code in soc-core.c,and the kernel provides
DEFINE_SHOW_ATTRIBUTE() helper macro to decrease it in seq_file.h.

Signed-off-by: Peng Donglin <dolinux.peng@gmail.com>
---
 sound/soc/soc-core.c | 51 +++++++++------------------------------------------
 1 file changed, 9 insertions(+), 42 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 96c44f6576c9..cb52d1e8e0b9 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -349,33 +349,22 @@ static void soc_init_codec_debugfs(struct
snd_soc_component *component)
             "ASoC: Failed to create codec register debugfs file\n");
 }

-static int codec_list_seq_show(struct seq_file *m, void *v)
+static int codec_list_show(struct seq_file *s, void *v)
 {
     struct snd_soc_codec *codec;

     mutex_lock(&client_mutex);

     list_for_each_entry(codec, &codec_list, list)
-        seq_printf(m, "%s\n", codec->component.name);
+        seq_printf(s, "%s\n", codec->component.name);

     mutex_unlock(&client_mutex);

     return 0;
 }
+DEFINE_SHOW_ATTRIBUTE(codec_list);

-static int codec_list_seq_open(struct inode *inode, struct file *file)
-{
-    return single_open(file, codec_list_seq_show, NULL);
-}
-
-static const struct file_operations codec_list_fops = {
-    .open = codec_list_seq_open,
-    .read = seq_read,
-    .llseek = seq_lseek,
-    .release = single_release,
-};
-
-static int dai_list_seq_show(struct seq_file *m, void *v)
+static int dai_list_show(struct seq_file *s, void *v)
 {
     struct snd_soc_component *component;
     struct snd_soc_dai *dai;
@@ -384,50 +373,28 @@ static int dai_list_seq_show(struct seq_file *m, void *v)

     list_for_each_entry(component, &component_list, list)
         list_for_each_entry(dai, &component->dai_list, list)
-            seq_printf(m, "%s\n", dai->name);
+            seq_printf(s, "%s\n", dai->name);

     mutex_unlock(&client_mutex);

     return 0;
 }
+DEFINE_SHOW_ATTRIBUTE(dai_list);

-static int dai_list_seq_open(struct inode *inode, struct file *file)
-{
-    return single_open(file, dai_list_seq_show, NULL);
-}
-
-static const struct file_operations dai_list_fops = {
-    .open = dai_list_seq_open,
-    .read = seq_read,
-    .llseek = seq_lseek,
-    .release = single_release,
-};
-
-static int platform_list_seq_show(struct seq_file *m, void *v)
+static int platform_list_show(struct seq_file *s, void *v)
 {
     struct snd_soc_platform *platform;

     mutex_lock(&client_mutex);

     list_for_each_entry(platform, &platform_list, list)
-        seq_printf(m, "%s\n", platform->component.name);
+        seq_printf(s, "%s\n", platform->component.name);

     mutex_unlock(&client_mutex);

     return 0;
 }
-
-static int platform_list_seq_open(struct inode *inode, struct file *file)
-{
-    return single_open(file, platform_list_seq_show, NULL);
-}
-
-static const struct file_operations platform_list_fops = {
-    .open = platform_list_seq_open,
-    .read = seq_read,
-    .llseek = seq_lseek,
-    .release = single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(platform_list);

 static void soc_init_card_debugfs(struct snd_soc_card *card)
 {
-- 
2.16.1
